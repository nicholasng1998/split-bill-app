package splitbill.service;

import splitbill.model.P2PSetupModel;

import java.util.List;

public interface P2PSetupService {

    void applyP2P(P2PSetupModel p2PSetupModel);

    List<P2PSetupModel> getAllActiveP2P();

}
