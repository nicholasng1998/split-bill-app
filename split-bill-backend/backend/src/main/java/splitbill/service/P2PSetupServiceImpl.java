package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.P2PSetupBean;
import splitbill.bean.UserBean;
import splitbill.dao.P2PSetupRepository;
import splitbill.dao.UserRepository;
import splitbill.model.P2PSetupModel;
import splitbill.util.AuthUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class P2PSetupServiceImpl implements P2PSetupService{

    private final P2PSetupRepository p2PSetupRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void applyP2P(P2PSetupModel p2PSetupModel) {

        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        P2PSetupBean p2PSetupBean = new P2PSetupBean();
        BeanUtils.copyProperties(p2PSetupModel, p2PSetupBean);
        p2PSetupBean.setStatus(P2PSetupBean.STATUS.ACTIVE.toValue());
        p2PSetupBean.setUserId(userBean.getUserId());
        p2PSetupBean.setRemainingAmount(p2PSetupBean.getLendAmount());
        p2PSetupBean.setCreatedDate(new Date());
        p2PSetupBean.setUpdatedDate(new Date());
        p2PSetupRepository.save(p2PSetupBean);

        log.info("p2PSetupBean: {}", p2PSetupBean);
    }

    @Override
    @Transactional(readOnly = true)
    public List<P2PSetupModel> getAllActiveP2P() {
        List<P2PSetupBean> p2PSetupBeans = p2PSetupRepository.findAll();

        List<P2PSetupModel> p2PSetupModels = new ArrayList<>();
        p2PSetupBeans.forEach(p2PSetupBean -> {
            P2PSetupModel p2PSetupModel = new P2PSetupModel();
            BeanUtils.copyProperties(p2PSetupBean, p2PSetupModel);
            p2PSetupModels.add(p2PSetupModel);
        });
        log.info("p2pSetupModels: {}", p2PSetupModels);

        return p2PSetupModels;
    }
}
