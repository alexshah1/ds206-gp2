import logging
import os

def setup_logger(pipeline_type, log_dir="logs"):

    # Set filename based on pipeline type
    if pipeline_type == "relational":
        filename = "logs_relational_data_pipeline.txt"
    elif pipeline_type == "dimensional":
        filename = "logs_dimensional_data_pipeline.txt"
    else:
        raise ValueError("Invalid pipeline type provided. Use 'relational' or 'dimensional'.")

    # Configure logging
    logger_name = f"{pipeline_type}"
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.DEBUG)
    
    # Define log file path
    log_file_path = os.path.join(log_dir, filename)
    
    # Check if handler already exists
    if not any(isinstance(handler, logging.FileHandler) and handler.baseFilename == log_file_path for handler in logger.handlers):
        # Create file handler for logging
        file_handler = logging.FileHandler(log_file_path)
        file_handler.setLevel(logging.DEBUG)
        
        # Create formatter
        formatter = logging.Formatter(f"%(asctime)s - %(execution_uuid)s - %(levelname)s - %(message)s")
        file_handler.setFormatter(formatter)
        
        # Add handlers to the logger
        logger.addHandler(file_handler)
    
    return logger

relational_logger = setup_logger("relational")
dimensional_logger = setup_logger("dimensional")