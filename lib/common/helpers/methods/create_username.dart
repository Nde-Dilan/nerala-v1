String generateUsernameFromEmail(String email) {
  // Extract part before @ symbol
  final username = email.split('@')[0];
  
  // Remove all digits
  final withoutNumbers = username.replaceAll(RegExp(r'[0-9]'), '');
  
  // Remove any consecutive underscores that might have been created
  final cleanUsername = withoutNumbers.replaceAll(RegExp(r'_{2,}'), '_');
  
  // Remove leading/trailing underscores
  return cleanUsername.trim().replaceAll(RegExp(r'^_|_$'), '');
}