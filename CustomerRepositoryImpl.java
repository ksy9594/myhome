package springHello;

import java.awt.print.Pageable;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepositoryImpl implements CustomerRepository
{
	private CustomerRepository repository;

	@Override
	public CustomerEntity findOne(long id) 
	{
		CustomerEntity customer = new CustomerEntity();
		customer.setid(id);
		customer.setname("권순영");
		// TODO Auto-generated method stub
		return customer;
	}
	@Override
	public List<CustomerEntity> findAll()
	{
		List<CustomerEntity> customers = new ArrayList<CustomerEntity>();
		for(int i = 0; i <10; i++)
		{
			CustomerEntity customer = new CustomerEntity();
			customer.setid(i);
			customer.setname("이름"+i);
		}
		return customers;
	}

}
