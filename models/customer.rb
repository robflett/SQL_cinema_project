require_relative( '../db/sql_runner.rb' )


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)

    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i

  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *;"
    customer = SqlRunner.run(sql).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    return self.get_many(sql)
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM customers;"
    return self.get_many(sql)
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = #{@id}"
    return Film.get_many(sql)
  end

  # def pay_for_ticket(price)
  #   @funds = @funds - price
  # end

  def buy_ticket_decrease_funds
    sql = "UPDATE customers SET funds = funds - price FROM films"
    SqlRunner.run(sql)
  end

end