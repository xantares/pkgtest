#include <stdio.h>
#include "libqhull_r/qhull_ra.h"

int main(void) {
    /* Example points: tetrahedron */
    coordT points[] = {
        0,0,0,
        1,0,0,
        0,1,0,
        0,0,1
    };

    int num_points = 4;
    int dim = 3;

    qhT *qh = NULL;
    int exitcode;

    /* allocate and initialize qh context */
    qh = (qhT*) malloc(sizeof(qhT));
    if (!qh) { fprintf(stderr, "malloc failed\n"); return 1; }

    qh_zero(qh, stderr);

    exitcode = qh_new_qhull(qh,
                            dim,
                            num_points,
                            points,
                            /* ismalloc? */ 0,
                            /* qhull options */ "qhull Qt",
                            /* outfile */ NULL,
                            /* errfile */ stderr);

    if (exitcode != 0) {
        fprintf(stderr, "Qhull failed: %d\n", exitcode);
        qh_freeqhull(qh, !qh_ALL);
        free(qh);
        return exitcode;
    }

    /* Iterate facets */
    facetT *facet;
    vertexT *vertex, **vertexp;

    printf("Convex hull facets:\n");

    for (facet = qh->facet_list; facet && facet->next; facet = facet->next) {
        if (facet->upperdelaunay) continue;

        printf("Facet: ");
        FOREACHvertex_(facet->vertices) {
            printf("(");
            for (int k = 0; k < dim; k++)
                printf("%g%s", vertex->point[k], (k+1<dim?",":""));
            printf(") ");
        }
        printf("\n");
    }

    /* Cleanup */
    qh_freeqhull(qh, !qh_ALL);

    int curlong, totlong;
    qh_memfreeshort(qh, &curlong, &totlong);
    if (curlong || totlong)
        fprintf(stderr, "Qhull lost memory: %d %d\n", curlong, totlong);

    free(qh);
    return 0;
}