

%% 

function RecursiveDisplayingMarker(markerStream)
    
    head = Head(markerStream);
    
    if(isempty(head))
        return
    end 
    
    disp(head);
    
    RecursiveDisplayingMarker(Tail(markerStream));
    
end
 