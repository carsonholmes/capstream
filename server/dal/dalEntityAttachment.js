// dalEntityAttachment.js
// Table: entity-attachment
//
// NOTE: Uses the existing mysql db wrapper. Do not modify dalDB.js.
// Import path assumes ../shared/db.js exports { dbo } with a mysql connection.

import db from '../shared/db.js';

const dalEntityAttachment = {
  // -----------------------------------------------------
  // INSERT
  // -----------------------------------------------------
  // SP: insertEntityAttachment(
  //   p_idAttachment CHAR(36),
  //   p_idEntity     CHAR(36),
  //   p_name         VARCHAR(255),
  //   p_fileName     VARCHAR(255),
  //   p_fileSize     BIGINT,
  //   p_fileExt      VARCHAR(16),
  //   p_dtAdded      DATETIME
  // )
  insertEntityAttachment: (data, callback) => {
    // Allow optional dtAdded to be NULL (SP will COALESCE to NOW())
    const dtAddedParam =
      data.dtAdded && data.dtAdded !== 'NULL' ? `"${data.dtAdded}"` : 'NULL';

    const params =
      `("${data.idAttachment}","${data.idEntity}","${data.name}",` +
      `"${data.fileName}","${data.fileSize}","${data.fileExt}",${dtAddedParam})`;

    try {
      db.dbo.query('CALL insertEntityAttachment' + params, (err, result) => {
        if (err) {
          console.error('Error inserting entity-attachment:', err);
          callback(err, 'Error inserting entity-attachment');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error inserting entity-attachment:', err);
      callback(err, 'Error inserting entity-attachment');
    }
  },

  // -----------------------------------------------------
  // SELECT (by idAttachment)
  // -----------------------------------------------------
  // SP: selectEntityAttachment(p_idAttachment CHAR(36))
  selectEntityAttachment: (data, callback) => {
    const params = `("${data.idAttachment}")`;

    try {
      db.dbo.query('CALL selectEntityAttachment' + params, (err, result) => {
        if (err) {
          console.error('Error selecting entity-attachment:', err);
          callback(err, 'Error selecting entity-attachment');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting entity-attachment:', err);
      callback(err, 'Error selecting entity-attachment');
    }
  },

  // -----------------------------------------------------
  // SELECT all attachments for an entity (newest first)
  // -----------------------------------------------------
  // SP: selectEntityAttachmentsByEntity(p_idEntity CHAR(36))
  selectEntityAttachmentsByEntity: (data, callback) => {
    const params = `("${data.idEntity}")`;

    try {
      db.dbo.query('CALL selectEntityAttachmentsByEntity' + params, (err, result) => {
        if (err) {
          console.error('Error selecting entity-attachments by entity:', err);
          callback(err, 'Error selecting entity-attachments by entity');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error selecting entity-attachments by entity:', err);
      callback(err, 'Error selecting entity-attachments by entity');
    }
  },

  // -----------------------------------------------------
  // UPDATE (by idAttachment)
  // -----------------------------------------------------
  // SP: updateEntityAttachment(
  //   p_idAttachment CHAR(36),
  //   p_idEntity     CHAR(36),
  //   p_name         VARCHAR(255),
  //   p_fileName     VARCHAR(255),
  //   p_fileSize     BIGINT,
  //   p_fileExt      VARCHAR(16),
  //   p_dtAdded      DATETIME
  // )
  updateEntityAttachment: (data, callback) => {
    const dtAddedParam =
      data.dtAdded && data.dtAdded !== 'NULL' ? `"${data.dtAdded}"` : 'NULL';

    const params =
      `("${data.idAttachment}","${data.idEntity}","${data.name}",` +
      `"${data.fileName}","${data.fileSize}","${data.fileExt}",${dtAddedParam})`;

    try {
      db.dbo.query('CALL updateEntityAttachment' + params, (err, result) => {
        if (err) {
          console.error('Error updating entity-attachment:', err);
          callback(err, 'Error updating entity-attachment');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error updating entity-attachment:', err);
      callback(err, 'Error updating entity-attachment');
    }
  },

  // -----------------------------------------------------
  // DELETE (by idAttachment)
  // -----------------------------------------------------
  // SP: deleteEntityAttachment(p_idAttachment CHAR(36))
  deleteEntityAttachment: (data, callback) => {
    const params = `("${data.idAttachment}")`;

    try {
      db.dbo.query('CALL deleteEntityAttachment' + params, (err, result) => {
        if (err) {
          console.error('Error deleting entity-attachment:', err);
          callback(err, 'Error deleting entity-attachment');
        } else {
          callback(null, result);
        }
      });
    } catch (err) {
      console.error('Error deleting entity-attachment:', err);
      callback(err, 'Error deleting entity-attachment');
    }
  }
};

export default dalEntityAttachment;
