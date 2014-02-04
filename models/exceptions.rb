class RegisterException < StandardError
end

class PasswordFailure < RegisterException
end

class EmptyField < RegisterException
end

class UsernameDuplicate < RegisterException
end
