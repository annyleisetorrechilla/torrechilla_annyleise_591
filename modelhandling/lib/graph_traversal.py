graph = {
    'A': ['C', 'B'],
    'B': ['A', 'D'],
    'C': ['A', 'E'],
    'D': ['B'],
    'E': ['C']
}

def dfs(graph, node, visited=None):
    if visited is None:
        visited = set()
    if node not in visited:
        print(node, end=' ')
        visited.add(node)
        for neighbor in graph[node]:
            dfs(graph, neighbor, visited)
            
print("Depth Traversal:")
dfs(graph, 'A')

from collections import deque
def bfs(graph, start):
    visited = set()
    queue = deque([start])

    while queue:
        node = queue.popleft()
        if node not in visited:
            print(node, end=' ')
            visited.add(node)
            queue.extend(neighbor for neighbor in graph[node] if neighbor not in visited)

print("\nBFS Traversal:")
bfs(graph, 'A')

#1. DFS visited node A and then visited its neighbors B and C.
#2. BFS visisted node A and then visited its neighbors B and C. After that it went to D and E respectively.
#3. The algorithms visit neighbors in the order they appear in the list. Flipping the order means they visit C first instead of B, so the output order changes.