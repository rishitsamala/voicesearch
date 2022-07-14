package app.voicesearch.model;

import java.io.Serializable;

public class SearchForm implements Serializable {

	private static final long serialVersionUID = 1913825251011054574L;
	private String plateNumber;
	private int expYear;
	private String vinNumber;
	private boolean hit;
	private String fname;
	private String mname;
	private String lname;

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public int getExpYear() {
		return expYear;
	}

	public void setExpYear(int expYear) {
		this.expYear = expYear;
	}

	public String getVinNumber() {
		return vinNumber;
	}

	public void setVinNumber(String vinNumber) {
		this.vinNumber = vinNumber;
	}

	public boolean isHit() {
		return hit;
	}

	public void setHit(boolean hit) {
		this.hit = hit;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

}
