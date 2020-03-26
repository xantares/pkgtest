
/***************************************************************************
 *   Copyright (C) 2017 by Pierre-Henri WUILLEMIN and Christophe GONZALES   *
 *   {prenom.nom}_at_lip6.fr                                               *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include <agrum/BN/BayesNet.h>
#include <agrum/BN/algorithms/essentialGraph.h>
#include <agrum/BN/inference/lazyPropagation.h>
#include <agrum/tools/multidim/potential.h>
#include <agrum/tools/variables/discretizedVariable.h>
#include <agrum/tools/variables/labelizedVariable.h>
#include <agrum/tools/variables/rangeVariable.h>

#define TS_ASSERT_EQUALS(x, y) { if (x != y) { std::ostringstream oss; oss << "got: " << x << " expected: " << y; throw std::invalid_argument(oss.str()); } }

  class EssentialGraphTestSuite {
    public:
    void testChain() {
      auto bn = gum::BayesNet< int >::fastPrototype("a->b->c");
      auto eg = gum::EssentialGraph(bn);

      TS_ASSERT_EQUALS(eg.size(), 3u);
      TS_ASSERT_EQUALS(eg.sizeArcs(), 0u);
      TS_ASSERT_EQUALS(eg.sizeEdges(), 2u);
    }

    void testVstructure() {
      auto bn = gum::BayesNet< int >::fastPrototype("a->b;c->b");
      auto eg = gum::EssentialGraph(bn);

      TS_ASSERT_EQUALS(eg.size(), 3u);
      TS_ASSERT_EQUALS(eg.sizeArcs(), 2u);
      TS_ASSERT_EQUALS(eg.sizeEdges(), 0u);
    }
    void testCaseD() {
      auto bn =
        gum::BayesNet< int >::fastPrototype("a->b;c1->b;c2->b;a->c1;a->c2");
      auto eg = gum::EssentialGraph(bn);

      TS_ASSERT_EQUALS(eg.size(), 4u);
      TS_ASSERT_EQUALS(eg.sizeArcs(), 3u);
      TS_ASSERT_EQUALS(eg.sizeEdges(), 2u);
    }

    void testNotebook1() {
      auto bn = gum::BayesNet< int >::fastPrototype(
        "A->B->C->D;E->B;F->G->D;F->H->I;E->J->K->I->M;K->L");
      auto eg = gum::EssentialGraph(bn);

      TS_ASSERT_EQUALS(eg.size(), 13u);
      TS_ASSERT_EQUALS(eg.sizeArcs(), 8u);
      TS_ASSERT_EQUALS(eg.sizeEdges(), 5u);
    }
    void testNotebook2() {
      auto bn = gum::BayesNet< int >::fastPrototype("A->B;C->B;C->D;B->D;A->C");
      auto eg = gum::EssentialGraph(bn);

      TS_ASSERT_EQUALS(eg.size(), 4u);
      TS_ASSERT_EQUALS(eg.sizeArcs(), 0u);
      TS_ASSERT_EQUALS(eg.sizeEdges(), 5u);
    }
    void testNotebook3() {
      auto bn = gum::BayesNet< int >::fastPrototype("Z->X->U;Y->X;Y->W");
      auto eg = gum::EssentialGraph(bn);

      TS_ASSERT_EQUALS(eg.size(), 5u);
      TS_ASSERT_EQUALS(eg.sizeArcs(), 3u);
      TS_ASSERT_EQUALS(eg.sizeEdges(), 1u);
    }
  };


static void test_order()
{
  gum::BayesNet<double> bn;
  bn.add(gum::RangeVariable("A", "A", 0, 1));
  bn.add(gum::RangeVariable("G", "G", 0, 3));
  bn.addArc("A", "G");
  bn.generateCPTs();
  for (int i = 0; i  < 30; ++i)
  {
    gum::LazyPropagation<double> ie(&bn);
    ie.addJointTarget({0, 1});
    ie.addEvidence("G", 1);
    ie.makeInference();
    std::cout << ie.jointPosterior({0, 1})<<std::endl;
  }
}

int main()
{
  //EssentialGraphTestSuite egts;
  //egts.testChain();
  //egts.testVstructure();
  //egts.testCaseD();
  //egts.testNotebook1();
  //egts.testNotebook2();
  //egts.testNotebook3();
  test_order();
  return 0;
}
