import csv

def csv_to_sql_insert(csv_file_path, table_name, output_file_path):
    # Step 1: Read the CSV file
    with open(csv_file_path, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        
        # Step 2: Generate SQL INSERT statements
        insert_statements = []
        
        for row in csv_reader:
            columns = ', '.join(row.keys())
            values = ', '.join([f"'{str(value).replace("'", "''")}'" if value is not None else 'NULL' for value in row.values()])
            insert_statement = f"INSERT INTO {table_name} ({columns}) VALUES ({values});"
            insert_statements.append(insert_statement)
        
    # Step 3: Write the SQL statements to a file
    with open(output_file_path, 'w') as output_file:
        for statement in insert_statements:
            output_file.write(statement + '\n')
    
    print(f"SQL INSERT statements have been written to {output_file_path}")

# Example usage:
csv_file_path = 'data.csv'  # Path to your CSV file
table_name = 'your_table_name'  # Name of your database table
output_file_path = 'output.sql'  # Path to the output SQL file

csv_to_sql_insert("database/Mock Data Final/world_bank_data-2.csv", "country", "database/Mock Data Inserts/countries.txt")

