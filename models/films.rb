require_relative( '../db/sql_runner.rb' )


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

def save
  sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *;"
  film = SqlRunner.run(sql).first
  @id = film['id'].to_i
end

def self.all()
  sql = "SELECT * FROM films;"
  #films = SqlRunner.run(sql)
  # result = films.map { |film| Film.new( film ) }
  # return result
  return self.get_many(sql)
end

def self.get_many(sql)
  films = SqlRunner.run(sql)
  result = films.map { |film| Film.new( film ) }
  return result
end

def self.delete_all()
  sql = "DELETE FROM films;"
  return self.get_many(sql)
end

def update
  sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id}"
  SqlRunner.run(sql)
end

def customers
  sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = #{@id}"
  return Customer.get_many(sql)
end

# def buy_ticket(customer)
#   customer.pay_for_ticket(@price)
# end

def showings
  sql = "SELECT tickets.* FROM tickets INNER JOIN films ON tickets.film_id = films.id WHERE ticket_id = #{@id}"
  return Ticket.get_many(sql)
end

end