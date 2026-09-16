/**
 * Helper utility functions for the backend API
 */

// Format response data consistently
function formatResponse(success, data = null, error = null) {
  return {
    success,
    data,
    error,
    timestamp: new Date().toISOString()
  };
}

// Generate random alphanumeric string
function generateRandomString(length = 10) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  for (let i = 0; i < length; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
}

module.exports = {
  formatResponse,
  generateRandomString
};
