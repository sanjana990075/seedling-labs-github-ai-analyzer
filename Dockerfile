FROM python:3.11-slim

# Set a working directory
WORKDIR /app

# Install system dependencies required by some Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	gcc \
	&& rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker layer caching
COPY requirements.txt ./

# Install Python dependencies
RUN python -m pip install --upgrade pip setuptools wheel && \
	pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app

# Use a non-root user for better security
RUN useradd --create-home appuser && chown -R appuser:appuser /app
USER appuser

# Expose port used by Uvicorn / FastAPI
EXPOSE 8000

# Default environment variables
ENV PYTHONUNBUFFERED=1
ENV PORT=8000

# Start the FastAPI app with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

