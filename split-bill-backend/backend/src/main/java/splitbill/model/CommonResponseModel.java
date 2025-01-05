package splitbill.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonResponseModel {

    private String status;
    private String errorMessage;

    public CommonResponseModel(String status) {
        this.status = status;
        this.errorMessage = null;
    }
}
