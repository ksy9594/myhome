package springHello;

import java.awt.print.Pageable;
import java.util.List;

public interface CustomerRepository 
{
	CustomerEntity findOne(long id);

	List<CustomerEntity> findAll();

}
