import java.util.ArrayList;

abstract class Sorter {
  public abstract void sort(ArrayList<Agent> al);

  public boolean lessThan(Agent a, Agent b) {
    //Returns true if and only if Agent a has less sugar than Agent b.
    if (a.getSugarLevel() < b.getSugarLevel()) {
      return true;
    } else {
      return false;
    }
  }
}

class BubbleSorter extends Sorter {
  public void sort(ArrayList<Agent> al) {
    if (al == null) {
      return;
    }
    if (al.size()==1) {
          return;
    }
    for (int n = 0; n <al.size(); n++) {
      for (int k = 0; k < al.size() - 1; k++) {
         if(lessThan(al.get(k+1), al.get(k))) {
          Agent temp =al.get(k+1);
          al.set(k+1, al.get(k));
          al.set(k, temp);
        }
      }
    }
  }
}

class InsertionSorter extends Sorter{
  public void sort(ArrayList<Agent> al) {
    if (al == null) {
      return;
    }
    else if (al.size() == 1){
      return;
    }
    for (int n = 1; n <al.size(); n++){
    Agent temp = al.get(n);
    int k;
    for (k = n - 1; n >= 0 && lessThan(temp, al.get(k)); k--){
      al.set(k+1, al.get(k));
    }
    al.set(k+1, temp);
    }
  }
}

public class MergeSorter extends Sorter {

  public void sort(ArrayList<Agent> al) {
    mergeSort(0, al.size() - 1, al, new ArrayList<Agent>(al));
  }

  private void mergeSort(int lowest, int highest, ArrayList<Agent> al, ArrayList<Agent> helper) {
    if (lowest < highest) {
      int middle = lowest + (highest - lowest) / 2;  
      mergeSort(lowest, middle, al, helper); 
      mergeSort(middle+1, highest, al, helper);
      merge(lowest, middle, highest, al, helper);
    }
  }

  private void merge(int lowest, int middle, int highest, ArrayList<Agent> al, ArrayList<Agent> helper) {
    int L = lowest;
    int R = middle + 1;

    for (int i = lowest; i <= highest; i++) {
      helper.set(i, al.get(i));
    }

    while (L <= middle && R <= highest) {
      Integer i = new Integer(helper.get(L).getSugarLevel());
      al.set(lowest++, i.compareTo(helper.get(R).getSugarLevel()) < 0 ? helper.get(L++) : helper.get(R++));
    }

    while (L <= middle) {
      al.set(lowest++, helper.get(L++));
    }
  }
}


class QuickSorter extends Sorter {
  private int len;

  public void sort(ArrayList<Agent> tobesorted) {
    if (tobesorted == null) {
      return;
    } else if (tobesorted.size() == 1) {
      return;
    }
    this.len = tobesorted.size();
    quickSort(tobesorted, 0, len - 1);
  }

  private void quickSort(ArrayList<Agent> tobesorted, int l, int h) {
    int pivot;
    if (l >= h) {
      return;
    }
    pivot = partition(tobesorted, l, h);
    quickSort(tobesorted, l, pivot - 1);
    quickSort(tobesorted, pivot + 1, h);
  }

  private int partition(ArrayList<Agent> tobesorted, int l, int h) {
    int pivotVal = tobesorted.get(l).getSugarLevel();
    int R = h;
    int L = l + 1;

    while (L <= R) {
      while (L <= h && tobesorted.get(L).getSugarLevel() <= pivotVal) {
        L++;
      }
      while (tobesorted.get(R).getSugarLevel() > pivotVal) {
        R--;
      }
      if (L < R) {
        swap(tobesorted, L, R);
        L++;
        R--;
      }
    }
    swap(tobesorted, l, R);
    return R;
  }

  private void swap(ArrayList<Agent> tobesorted, int i, int j) {
    Agent temp = tobesorted.get(i);
    tobesorted.set(i, tobesorted.get(j));
    tobesorted.set(j, temp);
  }
}