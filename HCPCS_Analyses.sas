/*Create Library*/

libname cciq '/home/sarahthompson31630/CCIQ/Program';

/*Indvidual HCPCS codes. Looking at frequencies and prevalence.
Will limit all list to the top 10 providers*/

/*HCPCS Code: 33282 Implantation patient-activated heart monitoring device*/

filename h33282 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_33282_US.csv';

proc import datafile= h33282
	dbms=csv
	replace
	out=cciq.h33282;
run;

proc contents data= cciq.h33282;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 33282 by NPI';
proc sgplot data = cciq.h33282;
	scatter x= NPI y= Number_of_Services;
	xaxis label = 'NPI'; 
	yaxis label = 'Number of Services'; 
run;

proc sort data=cciq.h33282;
	by descending Number_of_Services;
	run;

proc print data=cciq.h33282 (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Removal of ambulatory surgical center as they do no traditionally particpate in
ongoing care of a patient beyond the procedure*/

data cciq.h33282a;
	set cciq.h33282;
	if Provider_Type not = 'Ambulatory Surgical Center';
	if Provider_Type not = 'Clinical Laboratory';
run;

proc contents data= cciq.h33282a;
run;

Title 'Number of Services for HCPCS Code 33282 by NPI';
proc sgplot data = cciq.h33282a;
	scatter x= NPI y= Number_of_Services;
	xaxis label = 'NPI'; 
	yaxis label = 'Number of Services'; 
run;
proc sort data=cciq.h33282a;
	by descending Number_of_Services;
	run;

proc print data=cciq.h33282a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries. Duplication of above as patients can
only get one heart monitor a year(at a time)*/

Title 'Number of Beneficiaries for HCPCS Code 33282 by NPI';
proc sgplot data = cciq.h33282a;
	scatter x= NPI y= Number_of_Beneficiaries;
	xaxis label= 'NPI';
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h33282a;
	by descending Number_of_Beneficiaries;
run;

proc print data=cciq.h33282a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary. Again unecessary as this is a one
to one service. Ran just to look; it does appear as if some patients made have needed their
device replaced*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h33282b;
	set cciq.h33282a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS code 33282';
proc sgplot data = cciq.h33282b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h33282b;
	by descending Service_Ratio;
run;

Title 'Provider by Service Ratio for HCPCS code 33282';
proc print data=cciq.h33282b (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data = cciq.h33282b median mean;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h33282c;
	set cciq.h33282a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS Code 33282';
proc sgplot data=cciq.h33282c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h33282c;
	by Avg_Loss;
run;

Title 'Average Profit Loss for HCPCS Code 33282';
proc print data=cciq.h33282c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h33530b;
	by Avg_Payment_Amount;
run;

Title'Average Profit Loss by Least Payment for HCPCS Code 33282';
proc print data=cciq.h33530b (obs=10);
	var NPI Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;


/**NEWCODE**/
/*HCPCS Code: 33530 Reoperation of heart artery bypass or valve procedure more 
than 1 month after original operation*/

filename h33530 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_33530_US.csv';

proc import datafile= h33530
	dbms=csv
	replace
	out=cciq.h33530;
run;

proc contents data= cciq.h33530;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 33530 by NPI';
proc sgplot data = cciq.h33530;
	scatter x= NPI y= Number_of_Services;
	xaxis label= 'NPI';
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h33530;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS code 33530';
proc print data=cciq.h33530 (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 33530 by NPI';
proc sgplot data = cciq.h33530;
	scatter x= NPI y= Number_of_Beneficiaries;
run;

proc sort data=cciq.h33530;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS code 33530';
proc print data=cciq.h33530 (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h33530a;
	set cciq.h33530;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS Code 33530';
proc sgplot data = cciq.h33530a;
	histogram Service_Ratio;
run;

proc sort data= cciq.h33530a;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS Code 33530';
proc print data=cciq.h33530a (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data = cciq.h33530a median mean;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h33530b;
	set cciq.h33530;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS Code 33530';
proc sgplot data=cciq.h33530b;
	histogram Avg_Loss;
run;

proc sort data=cciq.h33530b;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS Code 33530';
proc print data=cciq.h33530b (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h33530b;
	by Avg_Payment_Amount;
run;
Title 'Top Ten Providers by Least Paid for HCPCS Code 33530';
proc print data=cciq.h33530b (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 33945 Transplantation of donor heart*/
/*Note this is a very specialized code and small dataset, not all observations
are necessary. It makes more sense to simply list the providers with the
addtional other variables*/

filename h33945 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_33945_US.csv';

proc import datafile= h33945
	dbms=csv
	replace
	out=cciq.h33945;
run;

proc contents data= cciq.h33945;
run;


/*Plot Number of Services and Number of Beneficiaries*/

Title 'Number of Services (and Beneficiaries) for HCPCS Code 33945 by NPI';
proc sgplot data = cciq.h33945;
	scatter x= NPI y= Number_of_Services;
	yaxis label = 'Number of Services (Beneficiaries)';
run;

Title 'Number of Beneficiaries for HCPCS Code 33945 by NPI';
proc sgplot data = cciq.h33945;
	scatter x= NPI y= Number_of_Beneficiaries;
run;

proc sort data=cciq.h33945;
	by descending Number_of_Services;
run;

Title 'Providers by Number of Services for HCPCS Code 33945';
proc print data=cciq.h33945;
	var NPI State Provider_Type Number_of_Services Number_of_Beneficiaries; 
run;

/*Do not need a Service Ratio column because people cannot get more than one heart transplant a year
 We can look at Average Loss but more for interest than anything else.Made one for paper example*/

data cciq.h33945b;
	set cciq.h33945;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;
Title 'Service Ratio for HCPCS code 33945';
proc sgplot data=cciq.h33945b;
	histogram Service_Ratio;
run;

data cciq.h33945a;
	set cciq.h33945;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

proc sort data= cciq.h33945a;
	by Avg_Loss;
run;

Title 'Average Loss Distribution for HCPCS code 33945';
proc sgplot data=cciq.h33945a;
	histogram Avg_Loss;
run;

Title 'Providers by Average Loss for HCPCS Code 33945';
proc print data=cciq.h33945a;
	var NPI State Number_of_Services 
	Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

Title 'Top Ten Providers by Least Paid for HCPCS code 33945';
proc print data=cciq.h33945a (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 33967 Insertion of assistive heart blood flow device into aorta, 
accessed through the skin. This is a highly specialized code as only patients in severe
heart failure require an assistive device. Most of the analyses were done but a full provider
list is included as all of these providers take care of severe HF patients */

filename h33967 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_33967_US.csv';

proc import datafile= h33967
	dbms=csv
	replace
	out=cciq.h33967;
run;

proc contents data= cciq.h33967;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services (Beneficiaries) for HCPCS Code 33967 by NPI';
proc sgplot data = cciq.h33967;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h33967;
	by descending Number_of_Services;
	run;

Title 'Providers by Number of Services for HCPCS Code 33967';
proc print data=cciq.h33967;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 33967 by NPI';
proc sgplot data = cciq.h33967;
	scatter x= NPI y= Number_of_Beneficiaries;
run;

proc sort data=cciq.h33967;
	by descending Number_of_Beneficiaries;
run;

proc print data=cciq.h33967;
	var NPI LName FName Street1 City State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary. Uneccessary since this is also
a highly specialized code and patients can only get one assist device per year*/

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h33967a;
	set cciq.h33530;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS code 33967';
proc sgplot data=cciq.h33967a;
	histogram Avg_Loss;
run;

proc sort data=cciq.h33967a;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS code 33967';
proc print data=cciq.h33967a (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h33967a;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS code 33967';
proc print data=cciq.h33967a (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 33979 Insertion of lower heart chamber blood flow assist device. 
Again, this is a highly specialized code as only patients in severe
heart failure require an assistive device. Most of the analyses were done but a full provider
list is included as all of these providers take care of severe HF patients*/

filename h33979 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_33979_US.csv';

proc import datafile= h33979
	dbms=csv
	replace
	out=cciq.h33979;
run;

proc contents data= cciq.h33979;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services (Beneficiaries) for HCPCS Code 33979 by NPI';
proc sgplot data = cciq.h33979;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h33979;
	by descending Number_of_Services;
	run;

Title 'Providers for HCPCS Code 33979';
proc print data=cciq.h33979;
	var NPI LName FName Street1 City State Number_of_Services;
run;

/*Analysis two: Total number of benficiaries.Just an overall visual look. 
Small dataset means less need for deep analysis*/

Title 'Number of Beneficiaries for HCPCS Code 33979 by NPI';
proc sgplot data = cciq.h33979;
	scatter x= NPI y= Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Not needed since there is onle one receipenent for each asssitive device*/

/*Analysis four: Difference between Avg submitted charge and Avg Payment
This is a look just because*/ 
/*Requires the creation of a new variable which means a new data set*/

data cciq.h33979a;
	set cciq.h33979;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS Code 33979';
proc sgplot data=cciq.h33979a;
	histogram Avg_Loss;
run;

proc sort data=cciq.h33979a;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss Table for HCPCS Code 33919';
proc print data=cciq.h33979a (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

proc sort data=cciq.h33979a;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS Code 33919';
proc print data=cciq.h33979a (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 75571 CT scan of heart with evaluation of blood vessel calcium*/

filename h75571 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_75571_US.csv';

proc import datafile= h75571
	dbms=csv
	replace
	out=cciq.h75571;
run;

proc contents data= cciq.h75571;
run;

/*Ran a similar diagnostic code earlier so we know that we need to take out some of
the provider types already. This includes IDTF, Nuclear Medicine, and Diagnostic Radiology as they
provide procedural services only*/

data cciq.h75571a;
	set cciq.h75571;
	if Provider_Type not = 'Independent Diagnostic Testing Facility (IDTF)';
	if Provider_Type not = 'Nuclear Medicine';
	if Provider_Type not = 'Diagnostic Radiology';
run;

proc contents data= cciq.h75571a;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 75571 by NPI';
proc sgplot data = cciq.h75571a;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h75571a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS Code 75571';	
proc print data=cciq.h75571a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of beneficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 75571 by NPI';
proc sgplot data = cciq.h75571a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h75571a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS Code 75571';
proc print data=cciq.h75571a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h75571b;
	set cciq.h75571a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS 75571';
proc sgplot data = cciq.h75571b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h75571b;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS 75571';
proc print data=cciq.h75571b (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data = cciq.h75571b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h75571c;
	set cciq.h75571a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS 75571';
proc sgplot data=cciq.h75571c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h75571c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS 75571';
proc print data=cciq.h75571c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h75571c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS 75571';
proc print data=cciq.h75571c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;


/*HCPCS Code: 78742 Nuclear medicine study of heart wall motion at rest or stress with evaluation 
of blood ejection from heart, single study*/

filename h78472 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_78472_US.csv';

proc import datafile= h78472
	dbms=csv
	replace
	out=cciq.h78472;
run;

proc contents data= cciq.h78472;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 78472 by NPI';
proc sgplot data = cciq.h78472;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h78472;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS code 78472';
proc print data=cciq.h78472 (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Looked back at the dataset in Excel and opted to remove Provider Types:
IDTF, Nuclear Medicine and Diagnostic Radiology since they are purely procedure based practices*/

data cciq.h78472a;
	set cciq.h78472;
	if Provider_Type not = 'Independent Diagnostic Testing Facility (IDTF)';
	if Provider_Type not = 'Nuclear Medicine';
	if Provider_Type not = 'Diagnostic Radiology';
run;

proc contents data= cciq.h78472a;
run;

Title 'Number of Services for HCPCS Code 78472 by NPI';
proc sgplot data = cciq.h78472a;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h78472a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS 78742';	
proc print data=cciq.h78472a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of beneficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 78472 by NPI';
proc sgplot data = cciq.h78472a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h78472a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS 78742';
proc print data=cciq.h78472a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h78472b;
	set cciq.h78472a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS 78472';
proc sgplot data = cciq.h78472b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h78472b;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS 78472';
proc print data=cciq.h78472b (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data = cciq.h78472b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h78472c;
	set cciq.h78472a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS 78472';
proc sgplot data=cciq.h78472c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h78472c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS 78472';
proc print data=cciq.h78472c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h78472c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS 78472';
proc print data=cciq.h78472c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 93018 Exercise or drug-induced heart and blood vessel stress test with 
EKG monitoring, physician interpretation and report*/

filename h93018 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_93018_US.csv';

proc import datafile= h93018
	dbms=csv
	replace
	out=cciq.h93018;
run;

proc contents data= cciq.h93018;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

data cciq.h93018a;
	set cciq.h93018;
	if Provider_Type not = 'Independent Diagnostic Testing Facility (IDTF)';
	if Provider_Type not = 'Nuclear Medicine';
	if Provider_Type not = 'Diagnostic Radiology';
run;

proc contents data= cciq.h93018a;
run;

Title 'Number of Services for HCPCS Code 93018 by NPI';
proc sgplot data = cciq.h93018a;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h93018a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS Code 93018';
proc print data=cciq.h93018a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of beneficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 93018 by NPI';
proc sgplot data = cciq.h93018a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h93018a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS Code 93018';
proc print data=cciq.h93018a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h93018b;
	set cciq.h93018a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS 93018';
proc sgplot data = cciq.h93018b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h93018b;
	by descending Service_Ratio;
run;
Title 'Top Ten Providers by Service Ratio for HCPCS 93018';
proc print data=cciq.h93018b (obs=10);
	var NPI State Provider_Type Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data = cciq.h93018b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h93018c;
	set cciq.h93018a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS 93018';
proc sgplot data=cciq.h93018c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h93018c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS 93018';
proc print data=cciq.h93018c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h93018c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS 93018';
proc print data=cciq.h93018c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;


/**NEWCODE**/

/*HCPCS Code: 93226 Heart rhythm analysis, interpretation and report of 48-hour EKG*/

filename h93226 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_93226_US.csv';

proc import datafile= h93226
	dbms=csv
	replace
	out=cciq.h93226;
run;

proc contents data= cciq.h93226;
run;

data cciq.h93226a;
	set cciq.h93226;
	if Provider_Type not = 'Independent Diagnostic Testing Facility (IDTF)';
	if Provider_Type not = 'Interventional Radiology';
run;

proc contents data= cciq.h93226a;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 93226 by NPI';
proc sgplot data = cciq.h93226a;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h93226a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS Code 93226';
proc print data=cciq.h93226a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of beneficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 93226 by NPI';
proc sgplot data = cciq.h93226a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h93226a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS Code 93226';
proc print data=cciq.h93226a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h93226b;
	set cciq.h93226a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS 93226';
proc sgplot data = cciq.h93226b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h93226b;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS 93226';
proc print data=cciq.h93226b (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data = cciq.h93226b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h93226c;
	set cciq.h93226a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS 93226';
proc sgplot data=cciq.h93226c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h93226c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS 93226';
proc print data=cciq.h93226c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h93226c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS 93226';
proc print data=cciq.h93226c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;



/**NEWCODE**/
/*HCPCS Code: 93228 Heart rhythm tracing, computer analysis, and interpretation of 
patient-triggered events greater than 24-hour EKG up to 30 days*/

filename h93228 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_93228_US.csv';

proc import datafile= h93228
	dbms=csv
	replace
	out=cciq.h93228;
run;

proc contents data= cciq.h93228;
run;

data cciq.h93228a;
	set cciq.h93293;
	if Provider_Type not = 'Independent Diagnostic Testing Fac';
	if Provider_Type not = 'Nuclear Medicine';
run;

proc contents data= cciq.h93228a;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 93228 by NPI';
proc sgplot data = cciq.h93228a;
	scatter x= NPI y= Number_of_Services;
	yaxis label = 'Number of Services';
run;

proc sort data=cciq.h93228a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS Code 93228';
proc print data=cciq.h93228a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 93228 by NPI';
proc sgplot data = cciq.h93228a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label = 'Number of Beneficiaries';
run;

proc sort data=cciq.h93228a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS Code 93228';
proc print data=cciq.h93228a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h93228b;
	set cciq.h93228a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS Code 93228';
proc sgplot data = cciq.h93228b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h93228b;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS Code 93228';
proc print data=cciq.h93228b (obs=10);
	var NPI State Provider_Type Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data = cciq.h93228b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h93228c;
	set cciq.h93228a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS 93228';
proc sgplot data=cciq.h93228c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h93228c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS Code 93228';
proc print data=cciq.h93228c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h93228c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS Code 93228';
proc print data=cciq.h93228c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 93293 Telephonic evaluation of single, dual, or multiple lead pacemaker heart rhythm 
strips up to 90 days*/

filename h93293 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_93293_US.csv';

proc import datafile= h93293
	dbms=csv
	replace
	out=cciq.h93293;
run;

proc contents data= cciq.h93293;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 93293 by NPI';
proc sgplot data = cciq.h93293;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h93293;
	by descending Number_of_Services;
	run;
	
proc print data=cciq.h93293 (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

data cciq.h93293a;
	set cciq.h93293;
	if Provider_Type not = 'Independent Diagnostic Testing Fac'; /*Note this was different*/
run;

proc contents data= cciq.h93293a;
run;

/*This is the analysis to use*/

Title 'Number of Services for HCPCS Code 93293 by NPI';
proc sgplot data = cciq.h93293a;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h93293a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS Code 93293';	
proc print data=cciq.h93293a (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of beneficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 93293 by NPI';
proc sgplot data = cciq.h93293a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h93293a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS Code 93293';
proc print data=cciq.h93293a (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h93293b;
	set cciq.h93293a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary';
proc sgplot data = cciq.h93293b;
	histogram Service_Ratio;
run;

proc sort data= cciq.h93293b;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS Code 93293';
proc print data=cciq.h93293b (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data = cciq.h93293b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h93293c;
	set cciq.h93293a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS code 93293';
proc sgplot data=cciq.h93293c;
	histogram Avg_Loss;
run;

proc sort data=cciq.h93293c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS code 93293';
proc print data=cciq.h93293c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h93293c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS code 93293';
proc print data=cciq.h93293c (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 93297 Remote evaluations of implantable heart monitoring system with physician 
analysis, review, and report up to 30 days*/

filename h93297 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_93297_US.csv';

proc import datafile= h93297
	dbms=csv
	replace
	out=cciq.h93297;
run;

proc contents data= cciq.h93297;
run;


/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 93297 by NPI';
proc sgplot data = cciq.h93297;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.h93297;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS 93297';
proc print data=cciq.h93297 (obs=10);
	var NPI State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 93297 by NPI';
proc sgplot data = cciq.h93297;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h93297;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS 93297';
proc print data=cciq.h93297 (obs=10);
	var NPI State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h93297a;
	set cciq.h93297;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS 93297';
proc sgplot data = cciq.h93297a;
	histogram Service_Ratio;
run;

proc sort data= cciq.h93297a;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS 93297';
proc print data=cciq.h93297a (obs=10);
	var NPI State Provider_Type Service_Ratio;
run;

proc means data= cciq.h93297a median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h93297b;
	set cciq.h93297;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS 93297';
proc sgplot data=cciq.h93297b;
	histogram Avg_Loss;
run;

proc sort data=cciq.h93297b;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS 93297';
proc print data=cciq.h93297b (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h93297b;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS 93297';
proc print data=cciq.h93297b (obs=10);
	var NPI State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: 93797 Physician services for outpatient heart cardiac rehabilitation per session*/

filename h93797 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_93797_US.csv';

proc import datafile= h93797
	dbms=csv
	replace
	out=cciq.h93797;
run;

proc contents data= cciq.h93797;
run;

/*I am including a full print out since there are only 31 observations*/

proc sort data= cciq.h93797;
	by descending Number_of_Services;
run;

proc print data= cciq.h93797;
	var NPI LName FName Street1 City State Number_of_Services Number_of_Beneficiaries;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code 93797 by NPI';
proc sgplot data = cciq.h93797;
	scatter x= NPI y= Number_of_Services;
run;

proc sort data=cciq.h93797;
	by descending Number_of_Services;
	run;

Title 'Providers listed by Number of Services by HCPCS code 93797';
proc print data=cciq.h93797;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code 93797 by NPI';
proc sgplot data = cciq.h93797;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.h93797;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS code 93797';
proc print data=cciq.h93797 (obs=10);
	var NPI LName FName Street1 City State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.h93797a;
	set cciq.h93797;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS 93797';
proc sgplot data = cciq.h93797a;
	histogram Service_Ratio;
run;

proc sort data= cciq.h93797a;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS 93797';
proc print data=cciq.h93797a (obs=10);
	var NPI LName FName Street1 City State Provider_Type Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data= cciq.h93797a median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.h93797b;
	set cciq.h93797;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution';
proc sgplot data=cciq.h93797b;
	histogram Avg_Loss;
run;

proc sort data=cciq.h93797b;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS 93797';
proc print data=cciq.h93797b (obs=10);
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.h93797b;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS 93797';
proc print data=cciq.h93797b (obs=10);
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*HCPCS code: G0250 Physician review, interpretation, and patient management 
of home inr testing for patient with either mechanical heart valve(s), chronic 
atrial fibrillation, or venous thromboembolism who meets medicare coverage criteria; 
testing not occurring more frequent*/

filename g0250 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_G0250_US.csv';

proc import datafile= g0250
	dbms=csv
	replace
	out=cciq.g0250;
run;

proc contents data= cciq.g0250;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code G0250 by NPI';
proc sgplot data = cciq.g0250;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.g0250;
	by descending Number_of_Services;
	run;

/*Although there is a couple of physicians with a high number of services compared to others
they all appear to be legitimate individual physicians rather than a diagnostic lab or group practice*/

Title 'Top Ten Providers by Number of Services for HCPCS G0250';
proc print data=cciq.g0250 (obs=10);
	var NPI LName FName Street1 City State Number_of_Services;
run;

/*Analysis two: Total number of beneficiaries*/

Title 'Number of Beneficiaries for HCPCS Code G0250 by NPI';
proc sgplot data = cciq.g0250;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.g0250;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS G0250';
proc print data=cciq.g0250 (obs=10);
	var NPI LName FName Street1 City State Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.g0250a;
	set cciq.g0250;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary';
proc sgplot data = cciq.g0250a;
	histogram Service_Ratio;
run;

proc sort data= cciq.g0250a;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS G0250';
proc print data=cciq.g0250a (obs=10);
	var NPI LName FName Street1 City State Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data= cciq.g0250a median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.g0250b;
	set cciq.g0250;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS code G0250';
proc sgplot data=cciq.g0250b;
	histogram Avg_Loss;
run;

proc sort data=cciq.g0250b;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS code G0250';
proc print data=cciq.g0250b (obs=10);
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.g0250b;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS code G0250';
proc print data=cciq.g0250b (obs=10);
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*HCPCS Code: G0398 Home sleep study test (hst) with type ii portable monitor, unattended; 
minimum of 7 channels: eeg, eog, emg, ecg/heart rate, airflow, respiratory effort and oxygen saturation*/

filename g0398 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_G0398_US.csv';

proc import datafile= g0398
	dbms=csv
	replace
	out=cciq.g0398;
run;

proc contents data= cciq.g0398;
run;

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code G0398 by NPI';
proc sgplot data = cciq.g0398;
	scatter x= NPI y= Number_of_Services;
run;

proc sort data=cciq.g0398;
	by descending Number_of_Services;
	run;
	
/*There is a diagnostic lab so that will need to be removed from the data set*/

data cciq.g0398a;
	set cciq.g0398;
	if Provider_Type not = 'Independent Diagnostic Testing Facility (IDTF)';
run;

proc contents data= cciq.g0398a;
run;

Title 'Number of Services for HCPCS Code G0398 by NPI';
proc sgplot data = cciq.g0398a;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.g0398a;
	by descending Number_of_Services;
	run;

Title 'Top Ten Providers by Number of Services for HCPCS Code G0398';	
proc print data=cciq.g0398a (obs=10);
	var NPI LName FName Street1 City State Provider_Type Number_of_Services;
run;

/*Most of the services were not provided by cardiology so just pulling those out*/
data cciq.g0398a1;
	set cciq.g0398a;
	if Provider_Type = 'Cardiology';
run;

Title 'Cardiology Providers for HCPCS Code G0398';
proc print data=cciq.g0398a1;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code G0398 by NPI';
proc sgplot data = cciq.g0398a;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.g0398a;
	by descending Number_of_Beneficiaries;
run;

Title 'Top Ten Providers by Number of Beneficiaries for HCPCS Code G0398';
proc print data=cciq.g0398a (obs=10);
	var NPI LName FName Street1 City State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.g0398b;
	set cciq.g0398a;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary';
proc sgplot data = cciq.g0398b;
	histogram Service_Ratio;
run;

proc sort data= cciq.g0398b;
	by descending Service_Ratio;
run;

Title 'Top Ten Providers by Service Ratio for HCPCS Code G0398';
proc print data=cciq.g0398b (obs=10);
	var NPI LName FName Street1 City State Provider_Type Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data= cciq.g0398b median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.g0398c;
	set cciq.g0398b;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS Code G0398';
proc sgplot data=cciq.g0398c;
	histogram Avg_Loss;
run;

proc sort data=cciq.g0398c;
	by Avg_Loss;
run;

Title 'Top Ten Providers by Average Loss for HCPCS Code G0398';
proc print data=cciq.g0398c (obs=10);
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.g0398c;
	by Avg_Payment_Amount;
run;

Title 'Top Ten Providers by Least Paid for HCPCS Code G0398';
proc print data=cciq.g0398c (obs=10);
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*HCPCS Code: G0422 Intensive cardiac rehabilitation; with or without continuous ecg 
monitoring with exercise, per session*/

filename g0422 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_G0422_US.csv';

proc import datafile= g0422
	dbms=csv
	replace
	out=cciq.g0422;
run;

proc contents data= cciq.g0422;
run;

/*Since there are only 15 observations in this dataset, the entire list
will be printed each time*/

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code G0422 by NPI';
proc sgplot data = cciq.g0422;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.g0422;
	by descending Number_of_Services;
	run;

/*There is an outlier but it is not a diagnostic lab or physician group*/

Title 'Providers by Number of Services for HCPCS Code G0422';
proc print data=cciq.g0422;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code G0422 by NPI';
proc sgplot data = cciq.g0422;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.g0422;
	by descending Number_of_Beneficiaries;
run;

Title 'Providers by Number of Beneficiaries for HCPCS Code G0422';
proc print data=cciq.g0422;
	var NPI LName FName Street1 City State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.g0422a;
	set cciq.g0422;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPS Code G0422';
proc sgplot data = cciq.g0422a;
	histogram Service_Ratio;
run;

proc sort data= cciq.g0422a;
	by descending Service_Ratio;
run;

Title 'Providers by Service Ratio for HCPCS Code G0422';
proc print data=cciq.g0422a;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data= cciq.g0422a median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.g0422b;
	set cciq.g0422a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS Code G0422';
proc sgplot data=cciq.g0422b;
	histogram Avg_Loss;
run;

proc sort data=cciq.g0422b;
	by Avg_Loss;
run;

Title 'Providers by Average Loss for HCPCS Code G0422';
proc print data=cciq.g0422b;
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.g0422b;
	by Avg_Payment_Amount;
run;

Title 'Providers by Least Paid for HCPCS Code G0422';
proc print data=cciq.g0422b;
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/**NEWCODE**/

/*HCPCS Code: G0423 Intensive cardiac rehabilitation; with or without continuous ecg monitoring; 
without exercise, per session. NOTE: same providers as above but in theory this is a sicker
population*/

filename g0423 '/home/sarahthompson31630/CCIQ/Datasets/MUP_HCPCS_G0423_US.csv';

proc import datafile= g0423
	dbms=csv
	replace
	out=cciq.g0423;
run;

proc contents data= cciq.g0423;
run;
/*Since there are only 15 observations in this dataset, the entire list
will be printed each time*/

/*Analysis one: Total number of services. Plot on graph first to identify
any potential outliers to remove*/

Title 'Number of Services for HCPCS Code G0423 by NPI';
proc sgplot data = cciq.g0423;
	scatter x= NPI y= Number_of_Services;
	yaxis label= 'Number of Services';
run;

proc sort data=cciq.g0423;
	by descending Number_of_Services;
	run;

/*There is an outlier but it is not a diagnostic lab or physician group*/

Title 'Providers by Number of Services for HCPCS Code G0423';
proc print data=cciq.g0423;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services;
run;

/*Analysis two: Total number of benficiaries*/

Title 'Number of Beneficiaries for HCPCS Code G0423 by NPI';
proc sgplot data = cciq.g0423;
	scatter x= NPI y= Number_of_Beneficiaries;
	yaxis label= 'Number of Beneficiaries';
run;

proc sort data=cciq.g0423;
	by descending Number_of_Beneficiaries;
run;

Title 'Providers by Number of Beneficiaries for HCPCS Code G0423';
proc print data=cciq.g0423;
	var NPI LName FName Street1 City State Provider_Type Number_of_Beneficiaries;
run;

/*Analysis three: Number of services per beneficiary*/
/*Need to create a new data set as it involves a new variable*/
data cciq.g0423a;
	set cciq.g0423;
	Service_Ratio = Number_of_Services/Number_of_Beneficiaries;
run;

Title 'Distribution of Number of Services per Beneficiary for HCPCS code G0423';
proc sgplot data = cciq.g0423a;
	histogram Service_Ratio;
run;

proc sort data= cciq.g0423a;
	by descending Service_Ratio;
run;

Title 'Providers by Service Ratio for HCPCS code G0423';
proc print data=cciq.g0423a;
	var NPI LName FName Street1 City State Provider_Type Number_of_Services Number_of_Beneficiaries Service_Ratio;
run;

proc means data= cciq.g0423a median mean max;
var Service_Ratio;
run;

/*Analysis four: Difference between Avg submitted charge and Avg Payment*/ 
/*Requries the creation of a new variable which means a new data set*/

data cciq.g0423b;
	set cciq.g0423a;
	Avg_Loss = Avg_Payment_Amount - Avg_Submitted_Charge; /*Note this will be a negative number*/
run;

Title 'Average Loss Distribution for HCPCS Code G0423';
proc sgplot data=cciq.g0423b;
	histogram Avg_Loss;
run;

proc sort data=cciq.g0423b;
	by Avg_Loss;
run;

Title 'Providers by Average Loss for HCPCS Code G0423';
proc print data=cciq.g0423b;
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;

/*Some providers charges are much larger than others which can skew the data. The following
sorts the data by Average Payment Amount to provide a look at who is being paid the least in total*/

proc sort data=cciq.g0423b;
	by Avg_Payment_Amount;
run;

Title 'Providers by Least Paid for HCPCS Code G0423';
proc print data=cciq.g0423b;
	var NPI LName FName Street1 City State Avg_Submitted_Charge Avg_Payment_Amount Avg_Loss;
run;





