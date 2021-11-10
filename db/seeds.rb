include FactoryBot::Syntax::Methods


customer1 = create(:customer)
customer2 = create(:customer)
tea1 = create(:tea)
tea2 = create(:tea)
tea3 = create(:tea)
tea4 = create(:tea)
tea5 = create(:tea)
sub1 = create(:subscription, customer: customer1, tea: tea1)
sub2 = create(:subscription, customer: customer1, tea: tea2)
sub3 = create(:subscription, customer: customer1, tea: tea3)
sub4 = create(:subscription, customer: customer2, tea: tea4)
sub5 = create(:subscription, customer: customer2, tea: tea5)
