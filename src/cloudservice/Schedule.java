/*-----------------------------
Schedule class 

Copyright NTHU CS15 Mao Chen-Ning 
-----------------------------*/

package cloudservice;

public class Schedule {
	public String time;
	public boolean available;
	
	public Schedule(){
		time = null;
		available = false;
	}
	
	public void setTime(String t){
		this.time = t;
	}
	
	public void setAvailable(int a){
		if(a == 1){
			this.available = true;
		}else {
			this.available = false;
		}
	}
}
