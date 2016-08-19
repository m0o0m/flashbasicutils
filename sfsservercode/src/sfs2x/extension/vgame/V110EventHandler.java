package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 10:38:54
 */
public class V110EventHandler extends BaseClientRequestHandler {

	public V110EventHandler(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1){


		SFSObject so_44062 = new SFSObject();
		 so_44062.putInt("hi",2);
		 so_44062.putInt("c",0);
		 SFSArray so_44062_sa_56656 = new SFSArray();
		so_44062.putSFSArray("au",so_44062_sa_56656);
		 SFSObject so_44062_sa_56656_so_86124 = new SFSObject();
		so_44062_sa_56656.addSFSObject(so_44062_sa_56656_so_86124);
		 so_44062_sa_56656_so_86124.putUtfString("sp","9411");
		 so_44062_sa_56656_so_86124.putUtfString("s","15092300018");
		 so_44062_sa_56656_so_86124.putUtfString("g","Dice");
		 SFSArray so_44062_sa_56656_so_86124_sa_99832 = new SFSArray();
		so_44062_sa_56656_so_86124.putSFSArray("ls",so_44062_sa_56656_so_86124_sa_99832);
		 SFSObject so_44062_sa_56656_so_86124_sa_99832_so_90668 = new SFSObject();
		so_44062_sa_56656_so_86124_sa_99832.addSFSObject(so_44062_sa_56656_so_86124_sa_99832_so_90668);
		 so_44062_sa_56656_so_86124_sa_99832_so_90668.putInt("ma",20000);
		 so_44062_sa_56656_so_86124_sa_99832_so_90668.putUtfString("l","4EE892C4-EA8D-4F87-A3F5-0CE741ED0768");
		 so_44062_sa_56656_so_86124_sa_99832_so_90668.putInt("mi",10);
		  SFSObject so_44062_sa_56656_so_86124_sa_99832_so_39089 = new SFSObject();
		so_44062_sa_56656_so_86124_sa_99832.addSFSObject(so_44062_sa_56656_so_86124_sa_99832_so_39089);
		 so_44062_sa_56656_so_86124_sa_99832_so_39089.putInt("ma",40000);
		 so_44062_sa_56656_so_86124_sa_99832_so_39089.putUtfString("l","A4A90E8D-F206-480D-BC98-3322C2A2C5F8");
		 so_44062_sa_56656_so_86124_sa_99832_so_39089.putInt("mi",20);
		  SFSObject so_44062_sa_56656_so_86124_sa_99832_so_26573 = new SFSObject();
		so_44062_sa_56656_so_86124_sa_99832.addSFSObject(so_44062_sa_56656_so_86124_sa_99832_so_26573);
		 so_44062_sa_56656_so_86124_sa_99832_so_26573.putInt("ma",100000);
		 so_44062_sa_56656_so_86124_sa_99832_so_26573.putUtfString("l","669D6D2B-92F3-4701-AB1A-442F856337CB");
		 so_44062_sa_56656_so_86124_sa_99832_so_26573.putInt("mi",50);
		  SFSObject so_44062_sa_56656_so_86124_sa_99832_so_77763 = new SFSObject();
		so_44062_sa_56656_so_86124_sa_99832.addSFSObject(so_44062_sa_56656_so_86124_sa_99832_so_77763);
		 so_44062_sa_56656_so_86124_sa_99832_so_77763.putInt("ma",200000);
		 so_44062_sa_56656_so_86124_sa_99832_so_77763.putUtfString("l","7CDACB09-AC92-46B1-90B5-3E6D3385D96B");
		 so_44062_sa_56656_so_86124_sa_99832_so_77763.putInt("mi",100);
		   so_44062_sa_56656_so_86124.putUtfString("sn","S07");
		 so_44062_sa_56656_so_86124.putDouble("inGameLimit",0);
		 so_44062_sa_56656_so_86124.putUtfString("si","127.0.0.1");
		  SFSObject so_44062_sa_56656_so_69526 = new SFSObject();
		so_44062_sa_56656.addSFSObject(so_44062_sa_56656_so_69526);
		 so_44062_sa_56656_so_69526.putUtfString("sp","9501");
		 so_44062_sa_56656_so_69526.putUtfString("s","14102800001");
		 so_44062_sa_56656_so_69526.putUtfString("g","Baccarat");
		 SFSArray so_44062_sa_56656_so_69526_sa_15862 = new SFSArray();
		so_44062_sa_56656_so_69526.putSFSArray("ls",so_44062_sa_56656_so_69526_sa_15862);
		 SFSObject so_44062_sa_56656_so_69526_sa_15862_so_87144 = new SFSObject();
		so_44062_sa_56656_so_69526_sa_15862.addSFSObject(so_44062_sa_56656_so_69526_sa_15862_so_87144);
		 so_44062_sa_56656_so_69526_sa_15862_so_87144.putInt("ma",1000);
		 so_44062_sa_56656_so_69526_sa_15862_so_87144.putUtfString("l","B39AB23F-5513-4EED-A425-1A36ED183BA5");
		 so_44062_sa_56656_so_69526_sa_15862_so_87144.putInt("mi",1);
		  SFSObject so_44062_sa_56656_so_69526_sa_15862_so_96752 = new SFSObject();
		so_44062_sa_56656_so_69526_sa_15862.addSFSObject(so_44062_sa_56656_so_69526_sa_15862_so_96752);
		 so_44062_sa_56656_so_69526_sa_15862_so_96752.putInt("ma",5000);
		 so_44062_sa_56656_so_69526_sa_15862_so_96752.putUtfString("l","40483917-9FCF-41E8-A88B-29D77B226889");
		 so_44062_sa_56656_so_69526_sa_15862_so_96752.putInt("mi",5);
		  SFSObject so_44062_sa_56656_so_69526_sa_15862_so_46953 = new SFSObject();
		so_44062_sa_56656_so_69526_sa_15862.addSFSObject(so_44062_sa_56656_so_69526_sa_15862_so_46953);
		 so_44062_sa_56656_so_69526_sa_15862_so_46953.putInt("ma",10000);
		 so_44062_sa_56656_so_69526_sa_15862_so_46953.putUtfString("l","654CAF9D-ECCC-468E-A9D3-793A0A2D0241");
		 so_44062_sa_56656_so_69526_sa_15862_so_46953.putInt("mi",10);
		  SFSObject so_44062_sa_56656_so_69526_sa_15862_so_37413 = new SFSObject();
		so_44062_sa_56656_so_69526_sa_15862.addSFSObject(so_44062_sa_56656_so_69526_sa_15862_so_37413);
		 so_44062_sa_56656_so_69526_sa_15862_so_37413.putInt("ma",50000);
		 so_44062_sa_56656_so_69526_sa_15862_so_37413.putUtfString("l","D5649EF9-50B7-4A73-B00D-E0766E2F3028");
		 so_44062_sa_56656_so_69526_sa_15862_so_37413.putInt("mi",50);
		  SFSObject so_44062_sa_56656_so_69526_sa_15862_so_56240 = new SFSObject();
		so_44062_sa_56656_so_69526_sa_15862.addSFSObject(so_44062_sa_56656_so_69526_sa_15862_so_56240);
		 so_44062_sa_56656_so_69526_sa_15862_so_56240.putInt("ma",100000);
		 so_44062_sa_56656_so_69526_sa_15862_so_56240.putUtfString("l","024089D0-7D98-491D-98F8-59626765E8AE");
		 so_44062_sa_56656_so_69526_sa_15862_so_56240.putInt("mi",100);
		   so_44062_sa_56656_so_69526.putUtfString("sn","S01");
		 so_44062_sa_56656_so_69526.putDouble("inGameLimit",0);
		 so_44062_sa_56656_so_69526.putUtfString("si","127.0.0.1");
		  SFSObject so_44062_sa_56656_so_30529 = new SFSObject();
		so_44062_sa_56656.addSFSObject(so_44062_sa_56656_so_30529);
		 so_44062_sa_56656_so_30529.putUtfString("sp","9933");
		 so_44062_sa_56656_so_30529.putUtfString("s","14102800002");
		 so_44062_sa_56656_so_30529.putUtfString("g","Baccarat");
		 SFSArray so_44062_sa_56656_so_30529_sa_2660 = new SFSArray();
		so_44062_sa_56656_so_30529.putSFSArray("ls",so_44062_sa_56656_so_30529_sa_2660);
		 SFSObject so_44062_sa_56656_so_30529_sa_2660_so_59363 = new SFSObject();
		so_44062_sa_56656_so_30529_sa_2660.addSFSObject(so_44062_sa_56656_so_30529_sa_2660_so_59363);
		 so_44062_sa_56656_so_30529_sa_2660_so_59363.putInt("ma",1000);
		 so_44062_sa_56656_so_30529_sa_2660_so_59363.putUtfString("l","0378F5B6-FAB3-49C5-8F2E-4E59F5D0954C");
		 so_44062_sa_56656_so_30529_sa_2660_so_59363.putInt("mi",1);
		  SFSObject so_44062_sa_56656_so_30529_sa_2660_so_88863 = new SFSObject();
		so_44062_sa_56656_so_30529_sa_2660.addSFSObject(so_44062_sa_56656_so_30529_sa_2660_so_88863);
		 so_44062_sa_56656_so_30529_sa_2660_so_88863.putInt("ma",5000);
		 so_44062_sa_56656_so_30529_sa_2660_so_88863.putUtfString("l","F494259D-1253-45C3-BFFE-92BB1CEDA15D");
		 so_44062_sa_56656_so_30529_sa_2660_so_88863.putInt("mi",5);
		  SFSObject so_44062_sa_56656_so_30529_sa_2660_so_71139 = new SFSObject();
		so_44062_sa_56656_so_30529_sa_2660.addSFSObject(so_44062_sa_56656_so_30529_sa_2660_so_71139);
		 so_44062_sa_56656_so_30529_sa_2660_so_71139.putInt("ma",10000);
		 so_44062_sa_56656_so_30529_sa_2660_so_71139.putUtfString("l","C18B9CAF-C18C-4E08-9968-498D737D81BB");
		 so_44062_sa_56656_so_30529_sa_2660_so_71139.putInt("mi",10);
		  SFSObject so_44062_sa_56656_so_30529_sa_2660_so_42181 = new SFSObject();
		so_44062_sa_56656_so_30529_sa_2660.addSFSObject(so_44062_sa_56656_so_30529_sa_2660_so_42181);
		 so_44062_sa_56656_so_30529_sa_2660_so_42181.putInt("ma",50000);
		 so_44062_sa_56656_so_30529_sa_2660_so_42181.putUtfString("l","96224BA5-77B2-4A4A-B34F-DDF536203115");
		 so_44062_sa_56656_so_30529_sa_2660_so_42181.putInt("mi",50);
		  SFSObject so_44062_sa_56656_so_30529_sa_2660_so_49797 = new SFSObject();
		so_44062_sa_56656_so_30529_sa_2660.addSFSObject(so_44062_sa_56656_so_30529_sa_2660_so_49797);
		 so_44062_sa_56656_so_30529_sa_2660_so_49797.putInt("ma",100000);
		 so_44062_sa_56656_so_30529_sa_2660_so_49797.putUtfString("l","D64733CE-67AC-4074-929A-DEC7AEABD237");
		 so_44062_sa_56656_so_30529_sa_2660_so_49797.putInt("mi",100);
		   so_44062_sa_56656_so_30529.putUtfString("sn","S02");
		 so_44062_sa_56656_so_30529.putDouble("inGameLimit",0);
		 so_44062_sa_56656_so_30529.putUtfString("si","127.0.0.1");
		  SFSObject so_44062_sa_56656_so_78490 = new SFSObject();
		so_44062_sa_56656.addSFSObject(so_44062_sa_56656_so_78490);
		 so_44062_sa_56656_so_78490.putUtfString("sp","9503");
		 so_44062_sa_56656_so_78490.putUtfString("s","14102800003");
		 so_44062_sa_56656_so_78490.putUtfString("g","Baccarat");
		 SFSArray so_44062_sa_56656_so_78490_sa_61121 = new SFSArray();
		so_44062_sa_56656_so_78490.putSFSArray("ls",so_44062_sa_56656_so_78490_sa_61121);
		 SFSObject so_44062_sa_56656_so_78490_sa_61121_so_91538 = new SFSObject();
		so_44062_sa_56656_so_78490_sa_61121.addSFSObject(so_44062_sa_56656_so_78490_sa_61121_so_91538);
		 so_44062_sa_56656_so_78490_sa_61121_so_91538.putInt("ma",1000);
		 so_44062_sa_56656_so_78490_sa_61121_so_91538.putUtfString("l","922355B6-7956-4E9D-BD68-21EE45D61C72");
		 so_44062_sa_56656_so_78490_sa_61121_so_91538.putInt("mi",1);
		  SFSObject so_44062_sa_56656_so_78490_sa_61121_so_58369 = new SFSObject();
		so_44062_sa_56656_so_78490_sa_61121.addSFSObject(so_44062_sa_56656_so_78490_sa_61121_so_58369);
		 so_44062_sa_56656_so_78490_sa_61121_so_58369.putInt("ma",5000);
		 so_44062_sa_56656_so_78490_sa_61121_so_58369.putUtfString("l","15C9B735-C04A-4E26-BA06-BB6D4D40096E");
		 so_44062_sa_56656_so_78490_sa_61121_so_58369.putInt("mi",5);
		  SFSObject so_44062_sa_56656_so_78490_sa_61121_so_67113 = new SFSObject();
		so_44062_sa_56656_so_78490_sa_61121.addSFSObject(so_44062_sa_56656_so_78490_sa_61121_so_67113);
		 so_44062_sa_56656_so_78490_sa_61121_so_67113.putInt("ma",10000);
		 so_44062_sa_56656_so_78490_sa_61121_so_67113.putUtfString("l","D5495466-9B22-4C25-B94D-56BFEF5778EE");
		 so_44062_sa_56656_so_78490_sa_61121_so_67113.putInt("mi",10);
		  SFSObject so_44062_sa_56656_so_78490_sa_61121_so_20072 = new SFSObject();
		so_44062_sa_56656_so_78490_sa_61121.addSFSObject(so_44062_sa_56656_so_78490_sa_61121_so_20072);
		 so_44062_sa_56656_so_78490_sa_61121_so_20072.putInt("ma",50000);
		 so_44062_sa_56656_so_78490_sa_61121_so_20072.putUtfString("l","15FAD436-0698-4027-A460-FE7AAA9E1064");
		 so_44062_sa_56656_so_78490_sa_61121_so_20072.putInt("mi",50);
		  SFSObject so_44062_sa_56656_so_78490_sa_61121_so_14253 = new SFSObject();
		so_44062_sa_56656_so_78490_sa_61121.addSFSObject(so_44062_sa_56656_so_78490_sa_61121_so_14253);
		 so_44062_sa_56656_so_78490_sa_61121_so_14253.putInt("ma",100000);
		 so_44062_sa_56656_so_78490_sa_61121_so_14253.putUtfString("l","87346DAA-EBB0-45F2-AB02-6752D0D37419");
		 so_44062_sa_56656_so_78490_sa_61121_so_14253.putInt("mi",100);
		   so_44062_sa_56656_so_78490.putUtfString("sn","S03");
		 so_44062_sa_56656_so_78490.putDouble("inGameLimit",0);
		 so_44062_sa_56656_so_78490.putUtfString("si","127.0.0.1");
		  SFSObject so_44062_sa_56656_so_91941 = new SFSObject();
		so_44062_sa_56656.addSFSObject(so_44062_sa_56656_so_91941);
		 so_44062_sa_56656_so_91941.putUtfString("sp","9505");
		 so_44062_sa_56656_so_91941.putUtfString("s","14121200008");
		 so_44062_sa_56656_so_91941.putUtfString("g","Baccarat");
		 SFSArray so_44062_sa_56656_so_91941_sa_66789 = new SFSArray();
		so_44062_sa_56656_so_91941.putSFSArray("ls",so_44062_sa_56656_so_91941_sa_66789);
		 SFSObject so_44062_sa_56656_so_91941_sa_66789_so_18894 = new SFSObject();
		so_44062_sa_56656_so_91941_sa_66789.addSFSObject(so_44062_sa_56656_so_91941_sa_66789_so_18894);
		 so_44062_sa_56656_so_91941_sa_66789_so_18894.putInt("ma",1000);
		 so_44062_sa_56656_so_91941_sa_66789_so_18894.putUtfString("l","57B8FDA7-6DA6-4D7D-8C6A-59FDC26A9019");
		 so_44062_sa_56656_so_91941_sa_66789_so_18894.putInt("mi",1);
		  SFSObject so_44062_sa_56656_so_91941_sa_66789_so_80091 = new SFSObject();
		so_44062_sa_56656_so_91941_sa_66789.addSFSObject(so_44062_sa_56656_so_91941_sa_66789_so_80091);
		 so_44062_sa_56656_so_91941_sa_66789_so_80091.putInt("ma",5000);
		 so_44062_sa_56656_so_91941_sa_66789_so_80091.putUtfString("l","9D21B9AD-59B0-4D7A-B2E9-264616E460DA");
		 so_44062_sa_56656_so_91941_sa_66789_so_80091.putInt("mi",5);
		  SFSObject so_44062_sa_56656_so_91941_sa_66789_so_88612 = new SFSObject();
		so_44062_sa_56656_so_91941_sa_66789.addSFSObject(so_44062_sa_56656_so_91941_sa_66789_so_88612);
		 so_44062_sa_56656_so_91941_sa_66789_so_88612.putInt("ma",10000);
		 so_44062_sa_56656_so_91941_sa_66789_so_88612.putUtfString("l","DDA187C0-F88B-4514-A548-B97112946524");
		 so_44062_sa_56656_so_91941_sa_66789_so_88612.putInt("mi",10);
		  SFSObject so_44062_sa_56656_so_91941_sa_66789_so_18122 = new SFSObject();
		so_44062_sa_56656_so_91941_sa_66789.addSFSObject(so_44062_sa_56656_so_91941_sa_66789_so_18122);
		 so_44062_sa_56656_so_91941_sa_66789_so_18122.putInt("ma",50000);
		 so_44062_sa_56656_so_91941_sa_66789_so_18122.putUtfString("l","FC178CEE-8914-491C-9021-0957878D2FAA");
		 so_44062_sa_56656_so_91941_sa_66789_so_18122.putInt("mi",50);
		  SFSObject so_44062_sa_56656_so_91941_sa_66789_so_21146 = new SFSObject();
		so_44062_sa_56656_so_91941_sa_66789.addSFSObject(so_44062_sa_56656_so_91941_sa_66789_so_21146);
		 so_44062_sa_56656_so_91941_sa_66789_so_21146.putInt("ma",100000);
		 so_44062_sa_56656_so_91941_sa_66789_so_21146.putUtfString("l","47CE2B3E-7E20-45BB-A70B-834F53A0F0D9");
		 so_44062_sa_56656_so_91941_sa_66789_so_21146.putInt("mi",100);
		   so_44062_sa_56656_so_91941.putUtfString("sn","S05");
		 so_44062_sa_56656_so_91941.putDouble("inGameLimit",0);
		 so_44062_sa_56656_so_91941.putUtfString("si","127.0.0.1");
		  SFSObject so_44062_sa_56656_so_31734 = new SFSObject();
		so_44062_sa_56656.addSFSObject(so_44062_sa_56656_so_31734);
		 so_44062_sa_56656_so_31734.putUtfString("sp","9504");
		 so_44062_sa_56656_so_31734.putUtfString("s","14121200007");
		 so_44062_sa_56656_so_31734.putUtfString("g","Baccarat");
		 SFSArray so_44062_sa_56656_so_31734_sa_54032 = new SFSArray();
		so_44062_sa_56656_so_31734.putSFSArray("ls",so_44062_sa_56656_so_31734_sa_54032);
		 SFSObject so_44062_sa_56656_so_31734_sa_54032_so_22520 = new SFSObject();
		so_44062_sa_56656_so_31734_sa_54032.addSFSObject(so_44062_sa_56656_so_31734_sa_54032_so_22520);
		 so_44062_sa_56656_so_31734_sa_54032_so_22520.putInt("ma",1000);
		 so_44062_sa_56656_so_31734_sa_54032_so_22520.putUtfString("l","088388A0-5C43-4394-AEFE-7B91927E7751");
		 so_44062_sa_56656_so_31734_sa_54032_so_22520.putInt("mi",1);
		  SFSObject so_44062_sa_56656_so_31734_sa_54032_so_49400 = new SFSObject();
		so_44062_sa_56656_so_31734_sa_54032.addSFSObject(so_44062_sa_56656_so_31734_sa_54032_so_49400);
		 so_44062_sa_56656_so_31734_sa_54032_so_49400.putInt("ma",5000);
		 so_44062_sa_56656_so_31734_sa_54032_so_49400.putUtfString("l","58C5E4CA-0DF6-4D6F-918B-9D9D69519D8A");
		 so_44062_sa_56656_so_31734_sa_54032_so_49400.putInt("mi",5);
		  SFSObject so_44062_sa_56656_so_31734_sa_54032_so_56981 = new SFSObject();
		so_44062_sa_56656_so_31734_sa_54032.addSFSObject(so_44062_sa_56656_so_31734_sa_54032_so_56981);
		 so_44062_sa_56656_so_31734_sa_54032_so_56981.putInt("ma",10000);
		 so_44062_sa_56656_so_31734_sa_54032_so_56981.putUtfString("l","67D322C9-738D-488E-B084-D1EC31A14587");
		 so_44062_sa_56656_so_31734_sa_54032_so_56981.putInt("mi",10);
		  SFSObject so_44062_sa_56656_so_31734_sa_54032_so_13622 = new SFSObject();
		so_44062_sa_56656_so_31734_sa_54032.addSFSObject(so_44062_sa_56656_so_31734_sa_54032_so_13622);
		 so_44062_sa_56656_so_31734_sa_54032_so_13622.putInt("ma",50000);
		 so_44062_sa_56656_so_31734_sa_54032_so_13622.putUtfString("l","3A1DC175-4F1D-4F59-8411-F9D9338A6AE0");
		 so_44062_sa_56656_so_31734_sa_54032_so_13622.putInt("mi",50);
		  SFSObject so_44062_sa_56656_so_31734_sa_54032_so_30187 = new SFSObject();
		so_44062_sa_56656_so_31734_sa_54032.addSFSObject(so_44062_sa_56656_so_31734_sa_54032_so_30187);
		 so_44062_sa_56656_so_31734_sa_54032_so_30187.putInt("ma",100000);
		 so_44062_sa_56656_so_31734_sa_54032_so_30187.putUtfString("l","06DD13C1-25FE-4456-B39D-5A5829B37219");
		 so_44062_sa_56656_so_31734_sa_54032_so_30187.putInt("mi",100);
		   so_44062_sa_56656_so_31734.putUtfString("sn","S06");
		 so_44062_sa_56656_so_31734.putDouble("inGameLimit",0);
		 so_44062_sa_56656_so_31734.putUtfString("si","127.0.0.1");
		 	 
		send("110",so_44062 ,arg0);
		V204EventHandler v204 = new V204EventHandler();
		this.getParentExtension().send("204", v204.so_85779, arg0);//百家乐
		this.getParentExtension().send("204", v204.so_14605, arg0);//骰宝
		//getApi().sendExtensionResponse("204", v204.so_14605, arg0, (Room) arg0.getLastJoinedRoom(), false);
		
		V226EventHandler v226 = new V226EventHandler();
		this.getParentExtension().send("226", v226.so_36357, arg0);
		this.getParentExtension().send("226", v226.so_56018, arg0);
		V227EventHandler v227 = new V227EventHandler();
		this.getParentExtension().send("227", v227.so, arg0);
	}
}//end V110EventHandler