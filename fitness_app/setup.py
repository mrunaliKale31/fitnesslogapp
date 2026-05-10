#!/usr/bin/env python3
"""
Setup script for Fitness Log Application
"""

from setuptools import setup, find_packages

setup(
    name='fitness-log',
    version='1.0.0',
    description='A professional fitness tracking application',
    author='Fitness App Developer',
    author_email='dev@example.com',
    url='https://example.com/fitness-log',
    packages=find_packages(),
    py_modules=['app', 'backend'],
    install_requires=[
        'Flask==3.0.0',
        'Werkzeug==3.0.1',
        'PySide6==6.6.0',
    ],
    entry_points={
        'console_scripts': [
            'fitness-log=app:main',
        ],
    },
    include_package_data=True,
    package_data={
        '': ['*.qml', '*.json', '*.desktop'],
    },
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: End Users/Desktop',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
    ],
)
