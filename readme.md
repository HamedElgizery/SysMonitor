# System Analytics and Reporting Software

Welcome to the System Analytics and Reporting Software! This software sis designed to retrive data about various system metrics including CPU performance, temperature, GPU stats, etc ... it also displays all those stats in either the gui using zenity and whiptail or a report in markdown or finally a live web visualization.

## Implementation
- **Logging**: Written in bash shell and python, uses Docker to run the loggers.
- **Reporting**: Written in python, uses the Markdown library to generate the reports.
- **Visualization**: Written in HTML, CSS, and JavaScript, uses Chart.js for the charts and Nodejs to host the html.

## Features

- **Logging**: Collects real-time data from your system using various logging scripts.
- **Reporting**: Generates detailed reports about system performance metrics.
- **Visualization**: Provides web-based visualizations of the collected data for easy analysis.

## Getting Started

To begin using the software, you need to follow these steps:

1. **Start the Logging Scripts**: 
   - Navigate to the `log_scripts` directory.
   - Run the `./startdocker.sh` script to initialize the logging processes.

    ```bash
    cd log_scripts
    ./startdocker.sh
    ```

2. **Run the Reporting Scripts**:
   - Navigate to the `reporting_scripts` directory.
   - Execute the `./startdocker.sh` script to start generating reports.

    ```bash
    cd reporting_scripts
    ./startdocker.sh
    ```

3. **Run the System Scripts**:
   - Navigate to the `sys_scripts` directory.
   - Run the `./startdocker.sh` script to manage system performance options.

    ```bash
    cd sys_scripts
    ./startdocker.sh
    ```

4. **Start the Web Visualization**:
   - Navigate to the `web-visualization` directory.
   - Execute the `./startdocker.sh` script to launch the web interface for data visualization.

    ```bash
    cd web-visualization
    ./startdocker.sh
    ```

## Usage

Once all scripts are running, you can access the web visualization to monitor and analyze system performance. The reports are stored in a designated reports directory and can be reviewed at any time.

