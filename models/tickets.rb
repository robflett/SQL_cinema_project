require_relative( '../db/sql_runner.rb' )



class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :time

  def initialize( options )

    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @time = options['time'].to_i

  end


  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING *;"
    ticket = SqlRunner.run(sql).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    #tickets = SqlRunner.run(sql)
    # result = tickets.map { |ticket| Ticket.new( ticket ) }
    # return result
    return self.get_many(sql)
  end

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    return self.get_many(sql)
  end

  def update #method available and correct but causes Foreign Key errors.
    sql = "UPDATE tickets SET (customer_id, film_id) = (#{@customer_id}, #{@film_id}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

end