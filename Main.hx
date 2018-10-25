import js.Browser.*;
import js.html.Event;
import postite.Sortable;

class Main {
	
	var sortable:Sortable;
	public function new() {
		trace( "new");

		var el = document.getElementById('items');
		 sortable = new Sortable(el,{onChoose:choose});
		 //Sortable.create(el,{onChoose:choose});
		sortable.option("onSort",sorted);
		sortable.option("onMove",move);
		Sortable.utils().on(document.querySelector("#items div[data-id='2']"),"click",function(e)trace( "clicked"));
	}

	function choose(e:SortEvent){
		trace( "choose"+ cast(e.target, js.html.Element).innerHTML);
		trace( e.oldIndex);
	}
	function sorted(evt:SortEvent){
		trace( evt);
		trace( evt.oldIndex );  // element's old index within parent
		trace( evt.newIndex);
		trace("dataset="+evt.item.dataset.id);
		trace( Sortable.active.toArray());
	}
	function move(moveEvt,origanlEvent){
		trace( moveEvt);
		trace( origanlEvent);
	}

	static public function main() {
		var app = new Main();
	}
}