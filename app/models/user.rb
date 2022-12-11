class User < ApplicationRecord
    validates:name,{presence:true,uniqueness:true}
    validates:password,{presence:true}
    validates:gid_m,{uniqueness:true}
end
