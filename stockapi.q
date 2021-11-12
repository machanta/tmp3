stockAPI:{[ndays;stocks] 
 stocks: distinct stocks,();  
 enddt: .z.p; 
 enddateL: `long$enddt;
 enddateL: enddateL-(1*24*60*60*1000*1000*1000); 
 startdateL: enddateL-(ndays*24*60*60*1000*1000*1000);
 tmi:{floor((`long$x)-`long$1970.01.01D00:00)%1e9};
 startdateY:tmi startdateL;
 enddateY:tmi enddateL;
 tbl:(); / initialize results table
 i:0;
 do[count stocks; /iterate over all the stocks
     stock: stocks[i];
     / txt:.Q.hg ":https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=1609459200&period2=1633910400&interval=1d&events=history&includeAdjustedClose=true"
     url:"https://query1.finance.yahoo.com/v7/finance/download/", (string stock) ,"?period1=",(string startdateY),"&period2=",(string enddateY),"&interval=1d&events=history&includeAdjustedClose=true";
     show url;
     txt:.Q.hg url;
     stocktable: ("DEEEEEEE";enlist",") 0:enlist txt; / parse the string and create a table from it
     stocktable: update Sym:stock from stocktable; / add a column with name of stock
     tbl,: stocktable; / append the table for this stock to tbl
     i+:1;
  ];
 tbl: select from tbl where not null Volume; / get rid of rows with nulls
 `Date`Sym xasc tbl} / order by date and stock
