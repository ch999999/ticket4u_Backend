# Instructions to set up database in local environment (If they still haven't given us Google Cloud Database)

Step 1: Must install Docker Desktop. (Prereq for windows: WSL)

Step 2: create .env file in root directory

Step 3: Copy contents of .env.example to your new .env file

Step 4: Run these commands to install essential python packages: pip install fastapi, pip install pylance, pip install alembic

Step 5: Run this command to create the database in a Docker container: docker-compose up -d

Step 6: Make sure container is running in Docker Desktop

Step 7: Create database migration script: alembic revision --autogenerate -m "initial migrate"

Step 8: Run migration: alembic upgrade head 

Step 9: Install pgAdmin

Step 10: Register server in pgAdmin. Name: ticket4u_db, Hostname/address: localhost, Port: 5433, Password: passwrd123 
