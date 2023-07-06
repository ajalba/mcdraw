using Godot;
using System;
using System.Collections;
using System.Collections.Generic;

public partial class monte_carlo : Node
{
	public double threshold = 0.000001;
	public int nextPointIndex(Vector3[] points, float sum) {
		double random = GD.RandRange(0.0,1.0)*sum;		
		List<Vector3> listPoints = new List<Vector3>();
		foreach (Vector3 point in points) {
			listPoints.Add(new Vector3(point[0], point[1], point[2]));
		}
		listPoints.Sort((x, y) => y[0].CompareTo(x[0]));
		for (int i = 0; i < listPoints.Count; i++) {
			if (random - listPoints[i][0] < 0) {
				return i;
			} else {
				random -= listPoints[i][0];
			}
		}
		return -1;
	}


	public Vector2 findNextPoint(Vector3[] points, float sum) {

		List<Vector3> listPoints = new List<Vector3>();
		foreach (Vector3 point in points) {
			listPoints.Add(new Vector3(point[0], point[1], point[2]));
		}
		double random = GD.RandRange(0.0,1.0)*sum;
		listPoints.Sort((x, y) => y[0].CompareTo(x[0]));

// IMPLEMENTACION 2
		foreach (Vector3 point in listPoints) {
			if (random - point[0] < 0) {
				return new Vector2(point[1], point[2]);
			} else {
				random -= point[0];
			}
		}

		return new Vector2(points[0][1], points[0][2]);
	}
}
