package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.ActivityBean;

import java.util.List;

@Repository
public interface ActivityRepository extends JpaRepository<ActivityBean, Integer> {

    List<ActivityBean> findAllByUserIdOrderByCreatedDateDesc(int userId);
}
