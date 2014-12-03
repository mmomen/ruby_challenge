class Person
  attr_reader :name
  attr_accessor :cash
  attr_accessor :bank_balance #using a hash to store\modify bank's balances - using a hash to avoid bank_balance being shared by banks (when created inside bank class) or staying within a person (integer value in person class)
  attr_accessor :credit_balance
  attr_accessor :credit_limit
  def initialize(name, cash)
    @name = name
    @cash = cash
    @bank_balance = Hash.new #TODO: move this outside person classs
    @credit_balance = Hash.new
    @credit_limit = Hash.new
    puts "Hi #{@name}, you are awesome and have $#{@cash} on hand!"
  end
end
class Bank
  attr_reader :bank_name
  def initialize(bank_name)
    @bank_name = bank_name
    @accounts = Hash.new #hash to store objects for accounts
    @credit_account = Hash.new
    puts "#{@bank_name} was just created."
  end
  def open_account(person)
    @accounts[person.name] = person
    @accounts[person.name].bank_balance[@bank_name] = 0 #setting the object as the key for the balance
    # p @accounts[person.name].bank_balance
    puts "#{person.name}, thanks for opening an account at #{@bank_name}!"
  end
  def deposit(person, amount)
    if  (@accounts[person.name].cash - amount) < 0
      puts "#{person.name} does not have enough cash to deposit $#{amount}"
    else
      @accounts[person.name].bank_balance[@bank_name] += amount
      @accounts[person.name].cash -= amount
      # p @accounts[person.name].bank_balance
      puts "#{@accounts[person.name].name} deposited $#{amount} to #{@bank_name}. #{@accounts[person.name].name} has $#{@accounts[person.name].cash}. #{@accounts[person.name].name}'s account has $#{@accounts[person.name].bank_balance[@bank_name]}."
      # p @accounts[person.name].bank_balance
    end
  end
  def withdraw(person, amount)
    if (@accounts[person.name].bank_balance[@bank_name] - amount) < 0
      puts "#{person.name} does not have enough money in the account to withdraw $#{amount}"
    else
      @accounts[person.name].bank_balance[@bank_name] -= amount
      @accounts[person.name].cash += amount
      # p @accounts[person.name].bank_balance
      puts "#{@accounts[person.name].name} withdrew $#{amount} from #{@bank_name}. #{@accounts[person.name].name} has $#{@accounts[person.name].cash}. #{@accounts[person.name].name}'s account has $#{@accounts[person.name].bank_balance[@bank_name]}."
      # p @accounts[person.name].bank_balance
    end
  end
  def transfer(person, bank_to, amount)
    if (@accounts[person.name].bank_balance[@bank_name] - amount) < 0
      puts "#{person.name} does not have enough money in the account to withdraw $#{amount}"
    else
      @accounts[person.name].bank_balance[@bank_name] -= amount #subtract from current bank
      @accounts[person.name].bank_balance[bank_to.bank_name] += amount #add to bank_to
      # p @accounts[person.name].bank_balance
      # p @accounts[person.name].bank_balance[bank_to.bank_name]
      puts "#{@accounts[person.name].name} transferred $#{amount} from the #{@bank_name} account to the #{bank_to.bank_name} account. The #{@bank_name} account has $#{@accounts[person.name].bank_balance[@bank_name]} and the #{bank_to.bank_name} account has $#{@accounts[person.name].bank_balance[bank_to.bank_name]}."
    end
  end
  def total_cash_in_bank
    # p @accounts
    x = 0
    @accounts.each do |a, b|
      @accounts[a].bank_balance.each do |bank, m|
        if bank == @bank_name
          x += m
        end
      end
    end
    return "#{@bank_name} has #{x} in the bank." #testcode puts this method, so this must be a return
  end
  def open_credit_account(person, limit)
    @credit_account[person.name] = person
    @credit_account[person.name].credit_limit[@bank_name] = limit
    @credit_account[person.name].credit_balance[@bank_name] = 0
    puts "#{person.name}, thanks for opening a credit card account with #{@bank_name}! Your credit limit is $#{limit} and your balance is $#{@credit_account[person.name].credit_balance[@bank_name]}"
  end
  def credit_purchase(person, amount)
    if (@credit_account[person.name].credit_limit[@bank_name] - (@credit_account[person.name].credit_balance[@bank_name] + amount)) < 0
      puts "#{person.name}'s card has been declined due to insufficent funds."
    else
      @credit_account[person.name].credit_balance[@bank_name] += amount
      puts "#{person.name} purchased an item for $#{amount}."
    end
    # p @credit_account[person.name].credit_limit
    # p @credit_account[person.name].credit_balance
  end
  def credit_limit(person)
    return "#{person.name} has a credit limit of $#{@credit_account[person.name].credit_limit[@bank_name]}. The current balance on the card is $#{@credit_account[person.name].credit_balance[@bank_name]}. Current available credit on the card is $#{@credit_account[person.name].credit_limit[@bank_name] - @credit_account[person.name].credit_balance[@bank_name]}."
  end
  def credit_refund(person, amount)
    @credit_account[person.name].credit_balance[@bank_name] -= amount
    puts "#{person.name}'s credit card was refunded for $#{amount}."
  end
end

#test code:
chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
me = Person.new("Shehzan", 500)
friend1 = Person.new("John", 1000)
chase.open_account(me)
chase.open_account(friend1)
wells_fargo.open_account(me)
wells_fargo.open_account(friend1)
chase.deposit(me, 200)
chase.deposit(friend1, 300)
chase.withdraw(me, 50)
chase.transfer(me, wells_fargo, 100)
chase.deposit(me, 5000)
chase.withdraw(me, 5000)
puts chase.total_cash_in_bank
puts wells_fargo.total_cash_in_bank
chase.open_credit_account(me, 1000)
chase.credit_purchase(me, 5000)
chase.credit_purchase(me, 200)
puts chase.credit_limit(me)
chase.credit_refund(me, 50)
puts chase.credit_limit(me)