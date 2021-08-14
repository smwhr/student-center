=== function listWithCommasAnd(list, if_empty) 
    {LIST_COUNT(list): 
    - 2: 
        	a {verbose(LIST_MIN(list))} and {listWithCommasAnd(list - LIST_MIN(list), if_empty)}
    - 1: 
        	a {verbose(list)}
    - 0: 
			{if_empty}	        
    - else: 
      		a {verbose(LIST_MIN(list))}, {listWithCommasAnd(list - LIST_MIN(list), if_empty)} 
    }

=== function listPartsWithCommas(list, if_empty) 
    {LIST_COUNT(list): 
    - 2: 
        	{some(LIST_MIN(list))} and {listPartsWithCommas(list - LIST_MIN(list), if_empty)}
    - 1: 
        	{some(list)}
    - 0: 
			{if_empty}	        
    - else: 
      		{some(LIST_MIN(list))}, {listPartsWithCommas(list - LIST_MIN(list), if_empty)} 
    }
    
=== function listNameWithCommasOr(list, if_empty) 
    {LIST_COUNT(list): 
    - 2: 
        	{verbose(LIST_MIN(list))} or {listNameWithCommasOr(list - LIST_MIN(list), if_empty)}
    - 1: 
        	{verbose(list)}
    - 0: 
			{if_empty}	        
    - else: 
      		{verbose(LIST_MIN(list))}, {listNameWithCommasOr(list - LIST_MIN(list), if_empty)} 
    }

=== function listWithCommasOr(list, if_empty) 
    {LIST_COUNT(list): 
    - 2: 
        	a {verbose(LIST_MIN(list))} or {listWithCommasOr(list - LIST_MIN(list), if_empty)}
    - 1: 
        	a {verbose(list)}
    - 0: 
			{if_empty}	        
    - else: 
      		a {verbose(LIST_MIN(list))}, {listWithCommasOr(list - LIST_MIN(list), if_empty)} 
    }
    
=== function verbose(obj) ===

{obj:
    - Ball: ball
    - Sunglasses: pair of sunglasses
    - PieceOfBuilding: piece of building
    - else : {obj}
}

=== function some(obj) ===

{obj:
    - Ball: a ball
    - Sunglasses: a pair of sunglasses
    - PieceOfBuilding: an edible piece of building
    - else : {obj}
}
=== pick_up(object) ===
{Inventory hasnt object:
    ~ Inventory += object
    You pickup the {verbose(object)}. # infotext
    Your inventory is now : {listWithCommasAnd(Inventory, "Nothing")}. # infotext

}
->->

=== drop(object, verb) ===
{Inventory has object:
    ~ Inventory -= object
    You {verb} the {verbose(object)}. # infotext
    Your inventory is now : {listWithCommasAnd(Inventory, "Nothing")}. # infotext

}
->->