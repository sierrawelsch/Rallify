import json

def json_to_sql_insert(json_file_path, table_name, output_file_path):
    # Step 1: Read the JSON file
    with open(json_file_path, 'r') as json_file:
        json_data = json.load(json_file)
    
    # Step 2: Parse the JSON data (Assume the JSON is a list of dictionaries)
    # Step 3: Generate SQL INSERT statements
    insert_statements = []
    
    for record in json_data:
        columns = ', '.join(record.keys())
        values = ', '.join([f"'{str(value).replace("'", "''")}'" if value is not None else 'NULL' for value in record.values()])
        insert_statement = f"INSERT INTO {table_name} ({columns}) VALUES ({values});"
        insert_statements.append(insert_statement)
    
    # Step 4: Write the SQL statements to a file
    with open(output_file_path, 'w') as output_file:
        for statement in insert_statements:
            output_file.write(statement + '\n')
    
    print(f"SQL INSERT statements have been written to {output_file_path}")

# Example usage:
json_file_path = 'data.json'  # Path to your JSON file
table_name = 'your_table_name'  # Name of your database table
output_file_path = 'output.sql'  # Path to the output SQL file


names= ["cause", "comments", "news_articles", "news_likes" ,"posts", "protest_attendence", "protest_likes", "protests", "user_interests", "users" ]

for x in names: 
    json_to_sql_insert("database/Mock Data Final/" + x + ".json", x, "database/Mock Data Inserts/" + x + ".txt")