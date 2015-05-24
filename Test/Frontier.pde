import java.util.*;

class Frontier {
  LinkedList<Image> l = new LinkedList<Image>();

  void add(Image s) {
    l.add(s);
  }

  Image remove() {
    return l.remove(0);
  }

  boolean isEmpty() {
    return l.isEmpty();
  }
}

