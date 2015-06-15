import java.util.*;

class PFrontier {

  LinkedList<Node> f = new LinkedList<Node>();
  //f is for frontier creative I know
  //This frontier is a priority list

  void add(Node n) {
    int i = 0;
    while (i < f.size ()) {
      if (n.getPri() < f.get(i).getPri()) {
        f.add(i, n);
        return;
      }
      i++;
    }
    f.add(i, n);
  }

  Node remove() {
    return f.remove();
  }

  boolean isEmpty() {
    return f.isEmpty();
  }
}

