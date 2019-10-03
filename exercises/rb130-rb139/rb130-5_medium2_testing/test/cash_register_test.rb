require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative '../lib/cash_register'
require_relative '../lib/transaction'


class CashRegisterTest < MiniTest::Test
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(20)
    @transaction.amount_paid = 25
  end

  def test_accept_money
    base_balance = @register.total_money
    @register.accept_money(@transaction)
    new_balance = @register.total_money
    assert_equal(base_balance + 25, new_balance)
  end

  def test_change
    assert_equal(5, @register.change(@transaction))
  end

  def test_give_receipt
    assert_output("You've paid $20.\n"){@register.give_receipt(@transaction)}
  end

  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30')
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal 30, transaction.amount_paid
  end
end