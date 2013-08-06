function xfade(hash){var ind = 1;var ind2 = 1;try{if(!hash){hash={fade:1000,rotate:3500}}if(hash["fade"]>hash["rotate"]){hash["fade"]=hash["rotate"]}if(bg){var order=[];var i=0;for(k in bg){order[i]=k;i++}$('#'+hash["container"]).html('<a id="xfade" href="'+bg[order[0]][0]+'" title="'+hash["title"]+'"><div id="main-fade" class="rotate '+bg[order[0]][1]+'">&nbsp;</div><div id="slave-fade" class="rotate '+bg[order[1]][1]+'">&nbsp;</div></a>');

    setInterval(function(){
        
        ind++;
        if( ind >= order.length ){ ind = 0 }
        
        if( $('#main-fade').css('opacity') == 1 ){
            
            $('#slave-fade').animate({opacity:1},hash["fade"]);
            $('#main-fade').animate({opacity:0},hash["fade"]);
            
            
            setTimeout(function(){
                
                $('#main-fade').attr('class','rotate '+bg[order[ind]][1]);
                
            },hash["fade"]+10);
            
        } else {
            
            $('#slave-fade').animate({opacity:0},hash["fade"]);
            $('#main-fade').animate({opacity:1},hash["fade"]);
            
            setTimeout(function(){
                
                $('#slave-fade').attr('class','rotate '+bg[order[ind]][1]);
                
            },hash["fade"]+10);

        }
        
    }, hash["rotate"] );
    
    }   
}catch(err){}}
