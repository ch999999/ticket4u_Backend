# Instructions to set up database in local environment (If they still haven't given us Google Cloud Database) Don't try unless your computer is good 8GB RAM + good processor

Step 1: Must install Docker Desktop. (Prereq for windows: WSL/Hyper-V - Enable in Windows features). SQLite can also, but doesn't support date and time types. You will have to modify connection string and code in database.py and may have to modify code in models.py and schemas.py that use date and time types.

Step 2: create .env file in root directory

Step 3: Copy contents of .env.example to your new .env file

Step 4: Run these commands to install essential python packages: pip install fastapi, pip install pylance, pip install sqlalchemy, pip install python-dotenv, pip install uvicorn

Step 5: Run this command to create the database in a Docker container: docker-compose up -d

Step 6: Make sure container is running in Docker Desktop

Step 7: Install pgAdmin

Step 8: Register server in pgAdmin. Name: ticket4u_db, Hostname/address: localhost, Port: 5433, Password: password123 

Step 9: To start API server and create tables in database, run this command from ticket4u_backend directory: uvicorn app.main:app

# Instructions to change database schema (table structure and relationships)
If models in models.py changed, database schema must be updated to reflect it.

Step 1: Shut down API server if still running

Step 2: In pgAdmin, copy and run thie SQL in resetdb.sql against ticket4u_db (NOT postgres!!!!)
This will drop all tables in ticket4u_db.

Step 3: restart API server. same command as Step 9 from previous section

# Inserting sample data
To clear tables, you can repeat Step 2 of the last section. After restarting the API server and regenerating database tables, copy and run the SQL in 
sample-data.sql to insert sample Cinemas, Halls, Seats, Movies, Showings and Users into the database.

