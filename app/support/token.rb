class Token

    PASSWORD = 'PlannerSecret'
    ALGORITHM = 'HS512'

    def encode(user)
        JWT.encode({id: user.id, email: user.email, view: user.view}, PASSWORD, ALGORITHM)
    end

    def decode(token)
        token_payload = JWT.decode(token, PASSWORD, true,  algorithm: ALGORITHM ).first.with_indifferent_access rescue nil
        token_payload && User.find_by(id: token_payload[:id])
    end

end