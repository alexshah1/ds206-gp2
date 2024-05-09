import logging
import os

def setup_logger(execution_uuid, log_dir="path", filename="logs.txt"):
    """Sets up and returns a logger with specific formatting and file handler."""
    # Ensure the logs directory exists
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
    
    # Configure logging
    logger = logging.getLogger(execution_uuid)
    logger.setLevel(logging.DEBUG)  # Log all levels of messages
    
    # Define log file path
    log_file_path = os.path.join(log_dir, filename)
    
    # Create file handler for logging
    file_handler = logging.FileHandler(log_file_path)
    file_handler.setLevel(logging.DEBUG)
    
    # Create formatter
    formatter = logging.Formatter(f'%(asctime)s - {execution_uuid} - %(levelname)s - %(message)s')
    file_handler.setFormatter(formatter)
    
    # Add handlers to the logger
    logger.addHandler(file_handler)
    
    return logger