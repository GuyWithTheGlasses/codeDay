class Node{
		int x, y;
		Node next;

		Node(int xcor, int ycor){
				x = xcor;
				y = ycor;
				next = null;
		}
		
		int getX(){
				return x;
		}
		void setX(int xcor){
		    x = xcor;
		}
		int getY(){
		    return y;
		}
		void setY(int ycor){
		    y = ycor;
		}
		Node getNext(){
				return next;
		}
		void setNext(Node n){
				next = n;
		}
		
}
