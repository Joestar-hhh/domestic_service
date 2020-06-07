package com.cykj.domestic.service;

import com.cykj.domestic.entity.Annoucement;
import com.cykj.domestic.util.ResultData;

public interface AnnoucementService {

    ResultData queryAnnoucementList( Annoucement annoucement,int page, int limit);

    ResultData insertAnnoucement(Annoucement annoucement);

    ResultData updateAnnoucement(Annoucement annoucement);

    ResultData deleteAnnoucement(String idList);
}
