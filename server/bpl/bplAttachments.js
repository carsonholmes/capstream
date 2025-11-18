// bplEntityAttachments.js
// Business Process Layer for entity-attachment records
//
// Notes:
// - Not an entity-backed object itself; uses idAttachment (UUID string) as PK and idEntity as FK.
// - Insert expects caller to provide idAttachment (UUID string) per your SP signature.
// - We perform lightweight business validation (required fields, simple bounds).
// - Insert returns the fully loaded attachment row; list returns newest-first (per SP).
//
// Required DAL:
//   dalEntityAttachment: insertEntityAttachment, selectEntityAttachment,
//                        selectEntityAttachmentsByEntity, updateEntityAttachment, deleteEntityAttachment

import dalEntityAttachment from '../dal/dalEntityAttachment.js';

// -------------------------------
// internal: validation helpers
// -------------------------------
function validateForInsert(data) {
  const errors = [];
  if (!data) errors.push('Missing payload.');
 if (!data?.idEntity) errors.push('idEntity is required (UUID).');
  if (!data?.fileName?.trim?.()) errors.push('fileName is required.');
  return errors;
}

function validateForUpdate(data) {
  const errors = [];
  if (!data?.idAttachment) errors.push('idAttachment is required for update.');
  if (!data?.idEntity) errors.push('idEntity is required for update.');
  return errors;
}

const bplEntityAttachments = {

  // -----------------------------------------------------
  // Load ONE attachment by idAttachment (UUID string)
  // -----------------------------------------------------
  loadAttachment: function (data, callback) {
    // expects: { idAttachment }
    if (!data?.idAttachment) return callback(false, { error: 'idAttachment is required.' });

    dalEntityAttachment.selectEntityAttachment(data, (errSel, resultSel) => {
      if (!errSel && resultSel && resultSel[0] && resultSel[0][0]) {
        callback(false, resultSel[0][0]); // single row
      } else {
        callback(false, { error: errSel || 'Attachment not found.' });
      }
    });
  },

  // -----------------------------------------------------
  // List attachments for an entity (newest first)
  // Perfect for UI galleries / tables
  // -----------------------------------------------------
  loadAttachmentsByEntity: function (data, callback) {
    // expects: { idEntity }
    if (!data?.idEntity) return callback(false, { error: 'idEntity is required.' });

    dalEntityAttachment.selectEntityAttachmentsByEntity(data, (errSel, resultSel) => {
      if (!errSel && resultSel && resultSel[0]) {
        callback(false, resultSel[0]); // array of rows
      } else {
        callback(false, { error: errSel || 'No attachments found.' });
      }
    });
  },

  // -----------------------------------------------------
  // Insert a new attachment
  // Returns the fully loaded row (round-trips via select)
  // -----------------------------------------------------
  insertAttachment: function (data, callback) {
    const errors = validateForInsert(data);
    if (errors.length) return callback(false, { error: errors.join(' ') });

    // dtAdded optional; DAL/SP will COALESCE to NOW() when omitted/NULL
    dalEntityAttachment.insertEntityAttachment(data, (errIns, resultIns) => {
      if (!errIns && resultIns && resultIns[0] && resultIns[0][0] && resultIns[0][0].idAttachment) {
        const idAttachment = resultIns[0][0].idAttachment;
        this.loadAttachment({ idAttachment }, (errLoad, row) => {
          if (!errLoad && row) callback(false, row);
          else callback(false, { error: errLoad || 'Inserted but failed to reload attachment.' });
        });
      } else {
        callback(false, { error: errIns || 'Insert failed.' });
      }
    });
  },

  // -----------------------------------------------------
  // Update an attachment
  // Returns { response: 'Success' } on success
  // -----------------------------------------------------
  updateAttachment: function (data, callback) {
    const errors = validateForUpdate(data);
    if (errors.length) return callback(false, { error: errors.join(' ') });

    dalEntityAttachment.updateEntityAttachment(data, (errUpd) => {
      if (!errUpd) callback(false, { response: 'Success' });
      else callback(false, { error: errUpd });
    });
  },

  // -----------------------------------------------------
  // Delete an attachment by idAttachment
  // Returns { response: 'Success' } on success
  // -----------------------------------------------------
  deleteAttachment: function (data, callback) {
    if (!data?.idAttachment) return callback(false, { error: 'idAttachment is required.' });

    dalEntityAttachment.deleteEntityAttachment(data, (errDel) => {
      if (!errDel) callback(false, { response: 'Success' });
      else callback(false, { error: errDel });
    });
  }
};

export default bplEntityAttachments;
