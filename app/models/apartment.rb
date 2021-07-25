class Apartment < ApplicationRecord
    has_many :leases
    has_many :tenants, through: :leases


    def detail
        {
            id: self.id,
            number: self.number,
            tenants: self.tenants.map{|tenant| {
                name: tenant.name,
                age: tenant.age
            }},
            rent: self.leases.map{|lease| {
                rent: lease.rent
            }}
        }
    end
end
