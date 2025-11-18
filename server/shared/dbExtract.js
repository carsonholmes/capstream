import db from './db.js';

// Function to get the DDL for a specific table
const getTableDDL = (tableName) => {
  return new Promise((resolve, reject) => {
    const query = `SHOW CREATE TABLE \`${tableName}\``;
    db.dbo.query(query, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]['Create Table']);
      }
    });
  });
};

// Function to get the list of all tables
const getAllTables = () => {
  return new Promise((resolve, reject) => {
    const query = 'SHOW TABLES';
    db.dbo.query(query, (error, results) => {
      if (error) {
        reject(error);
      } else {
        const tables = results.map(row => Object.values(row)[0]);
        resolve(tables);
      }
    });
  });
};

// Function to get the DDL for a specific stored procedure
const getProcedureDDL = (procedureName) => {
  return new Promise((resolve, reject) => {
    const query = `SHOW CREATE PROCEDURE \`${procedureName}\``;
    db.dbo.query(query, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]['Create Procedure']);
      }
    });
  });
};

// Function to get the list of all stored procedures
const getAllProcedures = () => {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT ROUTINE_NAME 
      FROM information_schema.ROUTINES 
      WHERE ROUTINE_TYPE='PROCEDURE' 
      AND ROUTINE_SCHEMA = DATABASE()
    `;
    db.dbo.query(query, (error, results) => {
      if (error) {
        reject(error);
      } else {
        const procedures = results.map(row => row.ROUTINE_NAME);
        resolve(procedures);
      }
    });
  });
};

// Main function to get DDL for all tables and stored procedures in the database
export const getDatabaseDDL = async () => {
  let ddlOut = "";

  try {
    // Get and print table DDLs
    const tables = await getAllTables();
    const tableDDLPromises = tables.map(table => getTableDDL(table));
    const tableDDLResults = await Promise.all(tableDDLPromises);

    tableDDLResults.forEach((ddl, index) => {
      ddlOut += `-- DDL for table ${tables[index]} --\n${ddl}\n\n`;
    });

    // Get and print stored procedure DDLs
    const procedures = await getAllProcedures();
    const procedureDDLPromises = procedures.map(proc => getProcedureDDL(proc));
    const procedureDDLResults = await Promise.all(procedureDDLPromises);

    procedureDDLResults.forEach((ddl, index) => {
      ddlOut += `-- DDL for procedure ${procedures[index]} --\n${ddl}\n\n`;
    });

    return ddlOut;

  } catch (error) {
    console.error('Error retrieving DDL:', error);
    throw error;  // Ensure the error is thrown to be handled by the caller
  }
};
