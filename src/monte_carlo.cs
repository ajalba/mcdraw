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
//			if (point[0]> 0.0) {
			listPoints.Add(new Vector3(point[0], point[1], point[2]));
//			}
		}
//IMPLEMENTACION 0
		double random = GD.RandRange(0.0,1.0)*sum;
//		foreach(Vector3 point in listPoints) {
//			if (random - point[0] < 0) {
//				return new Vector2(point[1], point[2]);
//			} else {
//				random -= point[0];
//			}
//		}
//		IMPLEMENTACION 1
//		GD.Print(listPoints.Count);
		listPoints.Sort((x, y) => y[0].CompareTo(x[0]));
//		double random = GD.RandRange(0.0,1.0);
//		bool found = false;
//		int iterations = 0;
//		while (!found && iterations < 3) {
//			for (int i=0; i< 10000; i++) {
//				int randomIndex = GD.RandRange(0, listPoints.Count - 1);
//				if (randomIndex > 0 ) {				
//					if (random - listPoints[randomIndex][0] < 0) {
//						found = true;
//						return new Vector2(listPoints[randomIndex][1], listPoints[randomIndex][2]);
//					} else {
//						random -= listPoints[randomIndex][0];
//					}
//				}
//			}
//			iterations += 1;
//		}

// IMPLEMENTACION 2
		foreach (Vector3 point in listPoints) {
			if (random - point[0] < 0) {
				return new Vector2(point[1], point[2]);
			} else {
				random -= point[0];
			}
		}

//		int nIters = 1000;
//		int nTests=10000;
//		double max = 0.0;
//		int randomI;
//		int maxIndex = 0;
//		GD.Randomize();
//		for(int i = 0; i<nIters; i++) {
//			for(int j=0;j<nTests;j++) {
//				randomI = GD.RandRange(0, listPoints.Count - 1);
//				if (listPoints[randomI][0] > max) {
//					max = listPoints[randomI][0];
//					maxIndex = randomI;
//				}
//			}
//		}
//		return new Vector2(listPoints[maxIndex][1], listPoints[maxIndex][2]);
		return new Vector2(points[0][1], points[0][2]);
	}
}
