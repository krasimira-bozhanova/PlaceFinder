module PlaceFinder
  class RegisterException < StandardError
  end

  # Raised when while registring the 'password' and the 'repeat_password'
  # fields are not the same
  class PasswordFailure < RegisterException
  end

  # Raised when while registring there is a field which contains only
  # whitespace characters or is empty
  class EmptyField < RegisterException
  end

  # Raised when there already exists a user with the same username
  class UsernameDuplicate < RegisterException
  end
end
