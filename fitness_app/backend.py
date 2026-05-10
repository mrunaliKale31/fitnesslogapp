#!/usr/bin/env python3
"""
Fitness Log App - Python Backend
Provides REST API for fitness tracking
"""

from flask import Flask, request, jsonify
from datetime import datetime, timedelta
import json
import os
from pathlib import Path
from collections import defaultdict

# Data storage file
DATA_FILE = Path(__file__).parent / "fitness_data.json"

def load_data():
    """Load fitness data from JSON file"""
    if DATA_FILE.exists():
        with open(DATA_FILE, 'r') as f:
            return json.load(f)
    return {"logs": [], "user_profile": {"name": "User", "goal": "Stay Fit"}}

def save_data(data):
    """Save fitness data to JSON file"""
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f, indent=2)

def create_app():
    """Create and configure Flask application"""
    app = Flask(__name__)
    
    @app.route('/api/logs', methods=['GET'])
    def get_logs():
        """Get all fitness logs"""
        data = load_data()
        return jsonify(data["logs"])

    @app.route('/api/logs', methods=['POST'])
    def add_log():
        """Add a new fitness log entry"""
        try:
            entry = request.json
            entry['timestamp'] = datetime.now().isoformat()
            entry['id'] = int(datetime.now().timestamp() * 1000)
            
            data = load_data()
            data["logs"].append(entry)
            save_data(data)
            
            return jsonify(entry), 201
        except Exception as e:
            return jsonify({"error": str(e)}), 400

    @app.route('/api/logs/<int:log_id>', methods=['DELETE'])
    def delete_log(log_id):
        """Delete a fitness log entry"""
        try:
            data = load_data()
            data["logs"] = [log for log in data["logs"] if log.get('id') != log_id]
            save_data(data)
            return jsonify({"success": True}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 400

    @app.route('/api/stats', methods=['GET'])
    def get_stats():
        """Get fitness statistics"""
        data = load_data()
        logs = data["logs"]
        
        if not logs:
            return jsonify({
                "total_workouts": 0,
                "total_calories": 0,
                "total_duration": 0,
                "average_duration": 0,
                "workouts_this_week": 0,
                "calories_this_week": 0
            })
        
        total_workouts = len(logs)
        total_calories = sum(log.get('calories', 0) for log in logs)
        total_duration = sum(log.get('duration', 0) for log in logs)
        average_duration = total_duration / total_workouts if total_workouts > 0 else 0
        
        # Calculate this week's stats
        week_ago = datetime.now() - timedelta(days=7)
        week_logs = [log for log in logs if datetime.fromisoformat(log.get('timestamp', '')) > week_ago]
        workouts_this_week = len(week_logs)
        calories_this_week = sum(log.get('calories', 0) for log in week_logs)
        
        return jsonify({
            "total_workouts": total_workouts,
            "total_calories": total_calories,
            "total_duration": total_duration,
            "average_duration": round(average_duration, 2),
            "workouts_this_week": workouts_this_week,
            "calories_this_week": calories_this_week
        })

    @app.route('/api/stats/daily', methods=['GET'])
    def get_daily_stats():
        """Get daily breakdown of workouts"""
        data = load_data()
        logs = data["logs"]
        
        daily_stats = defaultdict(lambda: {"count": 0, "calories": 0, "duration": 0})
        
        for log in logs:
            date = datetime.fromisoformat(log.get('timestamp', '')).date().isoformat()
            daily_stats[date]["count"] += 1
            daily_stats[date]["calories"] += log.get('calories', 0)
            daily_stats[date]["duration"] += log.get('duration', 0)
        
        return jsonify(dict(daily_stats))

    @app.route('/api/stats/exercises', methods=['GET'])
    def get_exercise_stats():
        """Get statistics by exercise type"""
        data = load_data()
        logs = data["logs"]
        
        exercise_stats = defaultdict(lambda: {"count": 0, "calories": 0, "duration": 0})
        
        for log in logs:
            exercise = log.get('exercise', 'Unknown')
            exercise_stats[exercise]["count"] += 1
            exercise_stats[exercise]["calories"] += log.get('calories', 0)
            exercise_stats[exercise]["duration"] += log.get('duration', 0)
        
        return jsonify(dict(exercise_stats))

    @app.route('/api/profile', methods=['GET'])
    def get_profile():
        """Get user profile"""
        data = load_data()
        return jsonify(data.get("user_profile", {"name": "User", "goal": "Stay Fit"}))

    @app.route('/api/profile', methods=['POST'])
    def update_profile():
        """Update user profile"""
        try:
            data = load_data()
            data["user_profile"] = request.json
            save_data(data)
            return jsonify(data["user_profile"]), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 400

    @app.route('/api/health', methods=['GET'])
    def health_check():
        """Health check endpoint"""
        return jsonify({"status": "ok"}), 200

    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True, port=5000, host='127.0.0.1')
