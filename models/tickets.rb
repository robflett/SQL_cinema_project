require_relative( '../db/sql_runner.rb' )

attr_reader :id
attr_accessor :customer_id, :film_id

class Ticket

  def intialize(options)

    @id = options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i

  end


  def save
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING *;"
    ticket = SqlRunner.run(sql).first
    @id = ticket['id'].to_i
  end


end