String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'app-deleted':
      return 'The database was not found.';
    case 'expired-action-code':
      return 'The action code or link has expired.';
    case 'invalid-action-code':
      return 'The action code is invalid. This can happen if the code is malformed or has already been used.';
    case 'user-disabled':
      return 'The user corresponding to the provided credential has been disabled.';
    case 'user-not-found':
      return 'The user does not correspond to any credential.';
    case 'weak-password':
      return 'The password is too weak.';
    case 'email-already-in-use':
      return 'An account already exists with the provided email address.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'operation-not-allowed':
      return 'The account type corresponding to this credential is not yet activated.';
    case 'account-exists-with-different-credential':
      return 'Email is already associated with another account.';
    case 'auth-domain-config-required':
      return 'Authentication configuration was not provided.';
    case 'credential-already-in-use':
      return 'An account already exists for this credential.';
    case 'operation-not-supported-in-this-environment':
      return 'This operation is not supported in the current environment. Ensure it should be http or https.';
    case 'timeout':
      return 'The request timed out. The domain may not be authorized to perform operations.';
    case 'missing-android-pkg-name':
      return 'An Android app package name must be provided.';
    case 'missing-continue-uri':
      return 'A continue URL must be provided in the request.';
    case 'missing-ios-bundle-id':
      return 'An iOS app package name must be provided.';
    case 'invalid-continue-uri':
      return 'The continue URL provided in the request is invalid.';
    case 'unauthorized-continue-uri':
      return 'The domain of the continue URL is not authorized.';
    case 'invalid-dynamic-link-domain':
      return 'The provided dynamic link domain is not authorized or configured in the current project.';
    case 'argument-error':
      return 'Check the link configuration for the app.';
    case 'invalid-persistence-type':
      return 'The specified data persistence type is invalid.';
    case 'unsupported-persistence-type':
      return 'The current environment does not support the specified data persistence type.';
    case 'invalid-credential':
      return 'The credential has expired or is malformed.';
    case 'wrong-password':
      return 'Wrong password.';
    case 'invalid-verification-code':
      return 'The credential verification code is not valid.';
    case 'invalid-verification-id':
      return 'The credential verification ID is not valid.';
    case 'custom-token-mismatch':
      return 'The token is different from the requested standard.';
    case 'invalid-custom-token':
      return 'The provided token is not valid.';
    case 'captcha-check-failed':
      return 'The reCAPTCHA response token is not valid, has expired, or the domain is not allowed.';
    case 'invalid-phone-number':
      return 'The phone number is in an invalid format (E.164 standard).';
    case 'missing-phone-number':
      return 'A phone number is required.';
    case 'quota-exceeded':
      return 'The SMS quota has been exceeded.';
    case 'cancelled-popup-request':
      return 'Only one pop-up window request is allowed at a time.';
    case 'popup-blocked':
      return 'The pop-up window has been blocked by the browser.';
    case 'popup-closed-by-user':
      return 'The pop-up window was closed by the user without completing the provider login.';
    case 'unauthorized-domain':
      return 'The app domain is not authorized to perform operations.';
    case 'invalid-user-token':
      return 'The current user has not been identified.';
    case 'user-token-expired':
      return 'The current user token has expired.';
    case 'null-user':
      return 'The current user is null.';
    case 'app-not-authorized':
      return 'The application is not authorized to authenticate with the provided key.';
    case 'invalid-api-key':
      return 'The provided API key is invalid.';
    case 'network-request-failed':
      return 'Network connection failed.';
    case 'requires-recent-login':
      return "The user's last access time does not meet the security limit.";
    case 'too-many-requests':
      return 'Requests have been blocked due to unusual activities. Try again after some time.';
    case 'web-storage-unsupported':
      return 'The browser does not support storage, or the user has disabled this feature.';
    case 'invalid-claims':
      return 'Custom registration attributes are invalid.';
    case 'claims-too-large':
      return 'The request size exceeds the maximum allowed size of 1 Megabyte.';
    case 'id-token-expired':
      return 'The provided token code has expired.';
    case 'id-token-revoked':
      return 'The provided token code has lost validity.';
    case 'invalid-argument':
      return 'An invalid argument was provided to a method.';
    case 'invalid-creation-time':
      return 'The creation time needs to be a valid UTC date.';
    case 'invalid-disabled-field':
      return 'The disabled user property is invalid.';
    case 'invalid-display-name':
      return 'The user name is invalid.';
    case 'invalid-email-verified':
      return 'The email is invalid.';
    case 'invalid-hash-algorithm':
      return 'The HASH algorithm is not a compatible encryption.';
    case 'invalid-hash-block-size':
      return 'The HASH block size is not valid.';
    case 'invalid-hash-derived-key-length':
      return 'The length of the HASH derived key is not valid.';
    case 'invalid-hash-key':
      return 'The HASH key must have a valid byte buffer.';
    case 'invalid-hash-memory-cost':
      return 'The HASH memory cost is not valid.';
    case 'invalid-hash-parallelization':
      return 'The HASH parallelization loading is not valid.';
    case 'invalid-hash-rounds':
      return 'The HASH rounds are not valid.';
    case 'invalid-hash-salt-separator':
      return 'The separator field of the SALT generation algorithm must be a valid byte buffer.';
    case 'invalid-id-token':
      return 'The provided token code is not valid.';
    case 'invalid-last-sign-in-time':
      return 'The last login time must be a valid UTC date.';
    case 'invalid-page-token':
      return 'The next URL provided in the request is invalid.';
    case 'invalid-password':
      return 'The password is invalid; it must be at least 6 characters.';
    case 'invalid-password-hash':
      return 'The password HASH is not valid.';
    case 'invalid-password-salt':
      return 'The password SALT is not valid.';
    case 'invalid-photo-url':
      return 'The user photo URL is invalid.';
    case 'invalid-provider-id':
      return 'The provider identifier is not compatible.';
    case 'invalid-session-cookie-duration':
      return 'The session COOKIE duration must be a valid number in milliseconds, between 5 minutes and 2 weeks.';
    case 'invalid-uid':
      return 'The provided identifier must be at most 128 characters.';
    case 'invalid-user-import':
      return 'The user record to be imported is not valid.';
    case 'invalid-provider-data':
      return 'The provider data is not valid.';
    case 'maximum-user-count-exceeded':
      return 'The maximum allowed number of users to be imported has been exceeded.';
    case 'missing-hash-algorithm':
      return 'The HASH generation algorithm and its parameters must be provided to import users.';
    case 'missing-uid':
      return 'An identifier is required for the current operation.';
    case 'reserved-claims':
      return 'One or more custom properties provided used reserved words.';
    case 'session-cookie-revoked':
      return 'The session COOKIE has lost validity.';
    case 'uid-alread-exists':
      return 'The provided identifier is already in use.';
    case 'email-already-exists':
      return 'The provided email is already in use.';
    case 'phone-number-already-exists':
      return 'The provided phone number is already in use.';
    case 'project-not-found':
      return 'No project was found.';
    case 'insufficient-permission':
      return 'The used credential does not have permission to access the requested resource.';
    case 'internal-error':
      return 'The authentication server encountered an unexpected error while trying to process the request.';
    case 'INVALID_LOGIN_CREDENTIALS':
      return 'Invalid email or password';
    default:
      return 'Internal Server Error';
  }
}
