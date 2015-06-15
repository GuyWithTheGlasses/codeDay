import java.util.*;

class Frontier {
  LinkedList<Node> l = new LinkedList<Node>();

  void add(Node s) {
    l.add(s);
  }

  Node remove() {
    if (isEmpty()) {
      return null;
    } else {
      return l.remove(0);
    }
  }

  boolean isEmpty() {
    return l.isEmpty();
  }
}
