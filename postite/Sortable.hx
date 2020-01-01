package postite;
//https://github.com/RubaXa/Sortable// <ul id="items">
// 	<li>item 1</li>
// 	<li>item 2</li>
// 	<li>item 3</li>
// </ul>
// var el = document.getElementById('items');
// var sortable = Sortable.create(el);
// You can use any element for the list and its elements, not just ul/li. Here is an example with divs.
import js.html.Event;
import js.html.Element;


typedef Func= Dynamic;
// Options
typedef Selector=String;

@:publicFields
class SortEvent extends Event{

var to:Element;// — list, in which moved element.
var from:Element;// — previous list
var item:Element;// — dragged element
var clone:Element;//
var oldIndex:Null<Int>;//,Number|undefined — old index within parent
var newIndex:Null<Int>;//,Number|undefined — new index within parent
}
class  MoveEvent extends Event{var to:Element;//
var from:Element;//
var dragged:Element;//
var draggedRect:js.html.DOMRect;//
var related:Element;// — element on which have;guided
var relatedRect:js.html.DOMRect;//
}
typedef SortableOptions={

	?group:String,// "name",  // or { name: "...", pull: [true, false, clone], put: [true, false, array] }
	?sort:Bool,// true,  // sorting inside list
	?delay:Int,// 0, // time in milliseconds to define when the sorting should start
	?disabled:Bool,// false, // Disables the sortable if set to true.
	?store:Dynamic,// null,  // @see Store
	?animation:Int,// 150,  // ms, animation speed moving items when sorting, `0` — without animation
	?handle:Selector,// ".my-handle",  // Drag handle selector within list items
	?filter:Selector,// ".ignore-elements",  // Selectors that do not lead to dragging (String or Function)
	?preventOnFilter:Bool,// true, // Call `event.preventDefault()` when triggered `filter`
	?draggable:Selector,// ".item",  // Specifies which items inside the element should be draggable
	?ghostClass:Selector,// "sortable-ghost",  // Class name for the drop placeholder
	?chosenClass:Selector,// "sortable-chosen",  // Class name for the chosen item
	?dragClass:Selector,// "sortable-drag",  // Class name for the dragging item
	?dataIdAttr:String,// 'data-id',

	?forceFallback:Bool,// false,  // ignore the HTML5 DnD behaviour and force the fallback to kick in

	?fallbackClass:Selector,// "sortable-fallback",  // Class name for the cloned DOM Element when using forceFallback
	?fallbackOnBody:Bool,// false,  // Appends the cloned DOM Element into the Document's Body
	?fallbackTolerance:Int,// 0, // Specify in pixels how far the mouse should move before it's considered as a drag.        
	
	?scroll:Bool,// true, // or Element
	?scrollFn:Int->Int->Dynamic->Void,/* function(offsetX, offsetY, originalEvent) { ... }, // if you have custom scrollbar scrollFn may be used for autoscrolling
	scrollSensitivity:Int,// 30, // px, how near the mouse must be to an edge to start scrolling.
	scrollSpeed:Float,// 10, // px

	setData:Dynamic->Js.html.Element->Void,
	/* function (/** DataTransfer dataTransfer,  ElementdragEl) {
		dataTransfer.setData('Text', dragEl.textContent); // `dataTransfer` object of HTML5 DragEvent
	},
	*/
	// Element is chosen
	?onChoose:SortEvent->Void,/* function (Event evt) {
		evt.oldIndex;  // element index within parent
	},
	*/
	// Element dragging started
	?onStart:SortEvent->Void,/* function (Event evt) {
		evt.oldIndex;  // element index within parent
	},
	*/
	// Element dragging ended
	?onEnd:SortEvent->Void,/* function ( Event evt) {
		evt.oldIndex;  // element's old index within parent
		evt.newIndex;  // element's new index within parent
	},
	*/
	// Element is dropped into the list from another list
	?onAdd:SortEvent->Void,/* function (Event evt) {
		var itemEl = evt.item;  // dragged Element
		evt.from;  // previous list
		// + indexes from onEnd
	},
	*/
	// Changed sorting within list
	?onUpdate:SortEvent->Void,/* function ( Event evt) {
		var itemEl = evt.item;  // dragged Element
		// + indexes from onEnd
	},
	*/
	// Called by any change to the list (add / update / remove)
	?onSort:SortEvent->Void,/* function ( Event evt) {
		// same properties as onUpdate
	},
	*/
	// Element is removed from the list into another list
	?onRemove: SortEvent->Void,/*function ( Event evt) {
		// same properties as onUpdate
	},
	*/
	// Attempt to drag a filtered element
	?onFilter:SortEvent->Void,/* function ( Event evt) {
		var itemEl = evt.item;  // Element receiving the `mousedown|tapstart` event.
	},
	*/
	// Event when you move an item in the list or between lists
	?onMove:MoveEvent->js.html.DragEvent->Void,/* function ( Event evt,  Event originalEvent) {
		// Example: http://jsbin.com/tuyafe/1/edit?js,output
		evt.dragged; // dragged Element
		evt.draggedRect; // TextRectangle {left, top, right и bottom}
		evt.related; // Element on which have guided
		evt.relatedRect; // TextRectangle
		originalEvent.clientY; // mouse position
		// return false; — for cancel
	},
	*/
	// Called when creating a clone of element
	?onClone:SortEvent->Void,/* function ( Event evt) {
		var origEl = evt.item;
		var cloneEl = evt.clone;
	}
	*/

}
@:native("Sortable")
extern class Sortable {
	
	public  function new(el:Element,?options:SortableOptions);
	//Link to the active instance
	public static var active:Sortable;

	public static  function create(el:Element,?options:SortableOptions):Sortable;
	//Get or set the option.
	public function option(optionName:String,?val:Dynamic):Dynamic;
	//For each element in the set, get the first element that matches the selector by testing the element itself and traversing up through its ancestors in the DOM tree.

	public function closest(sel:Selector,?el:js.html.Element):js.html.Element;
	//Serializes the sortable's item data-id's (dataIdAttr option) into an array of string.
	public function toArray():Array<String>;
	//Sorts the elements according to the array.
	public function sort(order:Array<String>):Void;
	//Save the current sorting (see store)
	public function save():Void;
	//Removes the sortable functionality completely.
	public function destroy():Void;
	public static inline  function utils():Utils{
		return untyped __js__('Sortable.utils');
	}

}

extern class Utils{
	
public  function on(el:Element, event:String, fn:Func):Dynamic;// — attach an event handler function
public  function off(el:Element, event:String, fn:Func):Dynamic;// — remove an event handler

//public function css(el:Element):Dynamic{}//:Object — get the values of all the CSS properties
//public function css(el:Element, prop:String):Dynamic{}//:Mixed — get the value of style properties
//public function css(el:Element, props:Dynamic):Dynamic{}// — set more CSS properties
@:overload(function(el:Element):Dynamic{})
@:overload(function(el:Element, prop:String):Dynamic{})
@:overload(function(el:Element, props:Dynamic):Dynamic{})
public  function css(el:Element, prop:String, value:String):Dynamic;// — set one CSS properties

public  function find(ctx:Element, tagName:String, ?iterator:Func):Array<Element>;// — get elements by tag name
public  function bind(ctx:Dynamic, fn:Func):Dynamic;//Function — Takes a function and returns a new one that will always have a particular context
public function is(el:Element, selector:String):Bool;// — check the current matched set of elements against a selector
public function closest(el:Element, selector:String, ?ctx:Element):Null<Element>;//|Null — for each element in the set, get the first element that matches the selector by testing the element itself and traversing up through its ancestors in the DOM tree
public function clone(el:Element):Element;// — create a deep copy of the set of matched elements
public function toggleClass(el:Element, name:String, state:Bool):Void;// — add or remove one classes from each element
}